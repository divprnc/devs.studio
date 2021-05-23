import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../size_configuration.dart';
import '../../theme.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}


class _WalletPageState extends State<WalletPage> {
  String userId = "";
  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    userId = FirebaseAuth.instance.currentUser.uid;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
        _razorpay = Razorpay();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
  
  Razorpay _razorpay;

  bool isLoading = false;
  String addAmount = '', withdrawAmount = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Stream documentStream = FirebaseFirestore.instance
        .collection('UserTransactions')
        .doc(userId)
        .snapshots();
    SizeConfig().init(context);

    Image appLogo = new Image(
        image: new ExactAssetImage("assets/logos/home_icon.png"),
        height: 100.0,
        width: 90.0,
        alignment: FractionalOffset.center);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blue),
          title: appLogo,
        ),
        body: isLoading
            ? SpinKitRing(
                color: Colors.white,
                lineWidth: 4,
                size: 40,
              )
            : StreamBuilder<DocumentSnapshot>(
                stream: documentStream,
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    Fluttertoast.showToast(
                        msg: "Something went wrong",
                        toastLength: Toast.LENGTH_LONG);
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitRing(
                        color: Colors.blue,
                        lineWidth: 4,
                        size: 40,
                      ),
                    );
                  }
                  print(snapshot.data.data());
                  return SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            height: SizeConfig.safeBlockVertical * 20,
                            color: Colors.blue,
                            child: Column(
                              children: [
                                Container(
                                    width: SizeConfig.screenWidth,
                                    height: SizeConfig.screenHeight * 0.059,
                                    color: Colors.blue,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 15,
                                      ),
                                      child:
                                          Text("Amount", style: drawerStylew),
                                    )),
                                Container(
                                    color: Colors.blue,
                                    width: SizeConfig.screenWidth,
                                    height: SizeConfig.screenHeight * 0.059,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 15,
                                      ),
                                      child: Text(
                                          "₹ " +
                                              snapshot.data
                                                  .get('WalletAmount')
                                                  .toString(),
                                          style: drawerStylew),
                                    )),
                                Container(
                                  color: Colors.blue,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            side:
                                                BorderSide(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            showMaterialModalBottomSheet(
                                                bounce: true,
                                                animationCurve: Curves.bounceIn,
                                                elevation: 10,
                                                enableDrag: true,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15),
                                                  ),
                                                ),
                                                context: context,
                                                builder: (context) => Container(
                                                      // height: SizeConfig
                                                      //         .safeBlockVertical *
                                                      //     60,
                                                      child: Column(
                                                        children: [
                                                          Icon(Icons
                                                              .calendar_view_day_rounded),
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Text(
                                                            "Add Amount",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "OpenSans",
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Container(
                                                            // width: SizeConfig.safeBlockHorizontal *
                                                            //     100,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Form(
                                                                key: _formKey,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      "Enter Amount to Add in the Wallet",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "OpenSans",
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    TextFormField(
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            addAmount =
                                                                                value;
                                                                          });
                                                                        },
                                                                        validator:
                                                                            (balance) {
                                                                          if (int.parse(balance) <
                                                                              10) {
                                                                            return 'Minimum Amount Should be 10';
                                                                          }
                                                                          return null;
                                                                        },
                                                                        cursorHeight:
                                                                            20,
                                                                        decoration: InputDecoration(
                                                                            enabledBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Colors.grey),
                                                                            ),
                                                                            focusedBorder: OutlineInputBorder(
                                                                              borderSide: BorderSide(color: Colors.blue),
                                                                            ),
                                                                            contentPadding: EdgeInsets.only(left: 10),
                                                                            hintText: "Amount",
                                                                            hintStyle: textFieldSize)),
                                                                    Container(
                                                                      width: SizeConfig
                                                                              .blockSizeHorizontal *
                                                                          100,
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          if (_formKey
                                                                              .currentState
                                                                              .validate()) {
                                                                            setState(() {
                                                                              isLoading = true;
                                                                            });
                                                                            // Navigator.of(context)
                                                                            //     .pop();
                                                                            setState(() {
                                                                              isLoading = false;
                                                                            });
                                                                          }
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          "Add Amount",
                                                                          style: TextStyle(
                                                                              fontFamily: "OpenSans",
                                                                              fontSize: 17,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ));
                                          },
                                          child: Text(
                                            "Add Amount",
                                            style: profileTextWhite,
                                          ),
                                        ),
                                        Container(
                                          width: SizeConfig.screenWidth * 0.3,
                                          child: OutlinedButton(
                                            style: OutlinedButton.styleFrom(
                                              side: BorderSide(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              showMaterialModalBottomSheet(
                                                  bounce: true,
                                                  animationCurve:
                                                      Curves.bounceIn,
                                                  elevation: 10,
                                                  enableDrag: true,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15),
                                                      topRight:
                                                          Radius.circular(15),
                                                    ),
                                                  ),
                                                  context: context,
                                                  builder:
                                                      (context) => Container(
                                                            // height: SizeConfig
                                                            //         .safeBlockVertical *
                                                            //     60,
                                                            child: Column(
                                                              children: [
                                                                Icon(Icons
                                                                    .calendar_view_day_rounded),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Text(
                                                                  "Withdraw Amount",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "OpenSans",
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Container(
                                                                  // width: SizeConfig.safeBlockHorizontal *
                                                                  //     100,
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Form(
                                                                      key:
                                                                          _formKey,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "Enter Amount to withdraw",
                                                                            style: TextStyle(
                                                                                fontFamily: "OpenSans",
                                                                                fontSize: 17,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          TextFormField(
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  addAmount = value;
                                                                                });
                                                                              },
                                                                              validator: (balance) {
                                                                                if (int.parse(balance) < 10) {
                                                                                  return 'Minimum Amount Should be 10';
                                                                                }
                                                                                return null;
                                                                              },
                                                                              cursorHeight: 20,
                                                                              decoration: InputDecoration(
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(color: Colors.grey),
                                                                                  ),
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                    borderSide: BorderSide(color: Colors.blue),
                                                                                  ),
                                                                                  contentPadding: EdgeInsets.only(left: 10),
                                                                                  hintText: "Amount",
                                                                                  hintStyle: textFieldSize)),
                                                                          Container(
                                                                            width:
                                                                                SizeConfig.blockSizeHorizontal * 100,
                                                                            child:
                                                                                ElevatedButton(
                                                                              onPressed: () {
                                                                                if (_formKey.currentState.validate()) {
                                                                                  setState(() {
                                                                                    isLoading = true;
                                                                                  });
                                                                                  // Navigator.of(context)
                                                                                  //     .pop();
                                                                                  setState(() {
                                                                                    isLoading = false;
                                                                                  });
                                                                                }
                                                                              },
                                                                              child: Text(
                                                                                "Withdraw",
                                                                                style: TextStyle(fontFamily: "OpenSans", fontSize: 17, fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ));
                                              // showDialog(
                                              //     context: context,
                                              //     builder:
                                              //         (BuildContext context) {
                                              //       return withdrawBalance(
                                              //           context);
                                              //     });
                                            },
                                            child: Text(
                                              "Withdraw",
                                              style: profileTextWhite,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight * 0.059,
                              child: Center(
                                  child: Text("Recent Transactions",
                                      style: drawerStyle))),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  border: Border.all(
                                    color: Colors.blue[900],
                                    width: 2,
                                  )),
                              width: SizeConfig.safeBlockHorizontal * 100,
                              height: SizeConfig.safeBlockVertical * 63,
                              child: ListView.builder(
                                itemCount:
                                    snapshot.data.get('Transactions').length,
                                itemBuilder: (BuildContext context, int index) {
                                  List mainTransactions =
                                      snapshot.data.get('Transactions');
                                  print(mainTransactions[index]["Transfer"] +
                                      " " +
                                      mainTransactions[index]["Type"]);
                                  return mainTransactions[index]["Transfer"] ==
                                              "OUT" &&
                                          mainTransactions[index]["Type"] ==
                                              "Quiz Joined"
                                      ? Card(
                                          elevation: 10,
                                          child: ListTile(
                                            subtitle: Text(
                                                mainTransactions[index]
                                                        ["DateAndTime"] +
                                                    "\n" +
                                                    "Quiz Id : " +
                                                    mainTransactions[index]
                                                        ["QuizId"]),
                                            isThreeLine: true,
                                            leading: Icon(Icons.remove,
                                                color: Colors.red),
                                            title: Text("Joined Contest"),
                                            trailing: Text(
                                              "₹ " +
                                                  mainTransactions[index]
                                                          ["Amount"]
                                                      .toString(),
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          child: Text("Hello"),
                                        );
                                  // Card(
                                  //   elevation: 10,
                                  //   child: ListTile(
                                  //     leading: Icon(Icons.add,
                                  //         color: Colors.green),
                                  //     title: Text("Amount Added"),
                                  //     trailing: Text("₹ 50"),
                                  //   ),
                                  // ),
                                  // Card(
                                  //   elevation: 10,
                                  //   child: ListTile(
                                  //     leading: Icon(Icons.remove,
                                  //         color: Colors.red),
                                  //     title: Text("Amount Deducted"),
                                  //     trailing: Text("₹ 50"),
                                  //   ),
                                  // ),
                                  // Card(
                                  //   elevation: 10,
                                  //   child: ListTile(
                                  //     leading: Icon(Icons.remove,
                                  //         color: Colors.red),
                                  //     title: Text("Joined Contest"),
                                  //     trailing: Text("₹ 5"),
                                  //   ),
                                  // ),
                                  // Card(
                                  //   elevation: 10,
                                  //   child: ListTile(
                                  //     leading: Icon(Icons.add,
                                  //         color: Colors.green),
                                  //     title: Text("Amount Won"),
                                  //     trailing: Text("₹ 10"),
                                  //   ),
                                  // ),
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ));
  }
}
