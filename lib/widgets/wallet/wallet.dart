import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../size_configuration.dart';
import '../../theme.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class MessageDisplayer {
  const MessageDisplayer(this.title);
  final String title;
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
  }

  final List<MessageDisplayer> _cast = <MessageDisplayer>[
    const MessageDisplayer("We are not accepting wallet payments"),
  ];
  final List<MessageDisplayer> _cast1 = <MessageDisplayer>[
    const MessageDisplayer("Please add your account details"),
  ];
  bool isLoading = false;
  String addAmount = '', withdrawAmount = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Iterable<Widget> get actorWidgets sync* {
    for (final MessageDisplayer actor in _cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: Chip(
          backgroundColor: Colors.blue[50],
          label: Text(
            actor.title,
            style: TextStyle(fontFamily: "OpenSans", color: Colors.blue[900]),
          ),
          onDeleted: () {
            setState(() {
              _cast.removeWhere((MessageDisplayer entry) {
                return entry.title == actor.title;
              });
            });
          },
        ),
      );
    }
  }

  Iterable<Widget> get actorWidgets1 sync* {
    for (final MessageDisplayer actor in _cast1) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: Chip(
          backgroundColor: Colors.blue[50],
          label: Text(
            actor.title,
            style: TextStyle(fontFamily: "OpenSans", color: Colors.blue[900]),
          ),
          onDeleted: () {
            setState(() {
              _cast.removeWhere((MessageDisplayer entry) {
                return entry.title == actor.title;
              });
            });
          },
        ),
      );
    }
  }

  Widget withdrawBalance(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 40,
        child: Container(
          width: SizeConfig.safeBlockHorizontal * 100,
          height: SizeConfig.safeBlockVertical * 28,
          child: Column(
            children: [
              Wrap(
                children: actorWidgets1.toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              addAmount = value;
                            });
                          },
                          validator: (balance) {
                            if (int.parse(balance) < 10) {
                              return 'Please withdraw minimum 10 Rupees';
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
                              hintStyle: textFieldSize),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: SizeConfig.safeBlockHorizontal * 30,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: ElevatedButton(
                              child: isLoading
                                  ? SpinKitRing(
                                      color: Colors.white,
                                      lineWidth: 4,
                                      size: 40,
                                    )
                                  : Text(
                                      "Withdraw",
                                      style: normalTextWhite,
                                    ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                            ),
                          ),
                          Container(
                            height: SizeConfig.safeBlockVertical * 6,
                            width: SizeConfig.safeBlockHorizontal * 30,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.red, fontFamily: "OpenSans"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget addBalance(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 40,
        child: Container(
          width: SizeConfig.safeBlockHorizontal * 100,
          height: SizeConfig.safeBlockVertical * 28,
          child: Column(
            children: [
              Wrap(
                children: actorWidgets.toList(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              addAmount = value;
                            });
                          },
                          validator: (balance) {
                            if (int.parse(balance) < 10) {
                              return 'Please add minimum 10 Rupees';
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
                              hintStyle: textFieldSize),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: SizeConfig.safeBlockHorizontal * 30,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: ElevatedButton(
                              child: isLoading
                                  ? SpinKitRing(
                                      color: Colors.white,
                                      lineWidth: 4,
                                      size: 40,
                                    )
                                  : Text(
                                      "Add",
                                      style: normalTextWhite,
                                    ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                            ),
                          ),
                          Container(
                            height: SizeConfig.safeBlockVertical * 6,
                            width: SizeConfig.safeBlockHorizontal * 30,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                    color: Colors.red, fontFamily: "OpenSans"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

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
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),
                                              ),
                                              context: context,
                                              builder: (context) => Container(
                                                height: SizeConfig
                                                        .safeBlockVertical *
                                                    50,
                                                child: Container(
                                                  width: SizeConfig
                                                          .safeBlockHorizontal *
                                                      100,
                                                  height: SizeConfig
                                                          .safeBlockVertical *
                                                      28,
                                                  child: Column(
                                                    children: [
                                                      Wrap(
                                                        children: actorWidgets
                                                            .toList(),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Form(
                                                          key: _formKey,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                width: SizeConfig
                                                                        .screenWidth *
                                                                    0.9,
                                                                height: SizeConfig
                                                                        .screenHeight *
                                                                    0.06,
                                                                child:
                                                                    TextFormField(
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
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
                                                                    if (int.parse(
                                                                            balance) <
                                                                        10) {
                                                                      return 'Please add minimum 10 Rupees';
                                                                    }
                                                                    return null;
                                                                  },
                                                                  cursorHeight:
                                                                      20,
                                                                  decoration:
                                                                      InputDecoration(
                                                                          enabledBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: Colors.grey),
                                                                          ),
                                                                          focusedBorder:
                                                                              OutlineInputBorder(
                                                                            borderSide:
                                                                                BorderSide(color: Colors.blue),
                                                                          ),
                                                                          contentPadding: EdgeInsets.only(
                                                                              left:
                                                                                  10),
                                                                          hintText:
                                                                              "Amount",
                                                                          hintStyle:
                                                                              textFieldSize),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Container(
                                                                width: SizeConfig
                                                                        .screenWidth *
                                                                    0.9,
                                                                height: SizeConfig
                                                                        .screenHeight *
                                                                    0.06,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .blue,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3),
                                                                ),
                                                                child:
                                                                    ElevatedButton(
                                                                  child: isLoading
                                                                      ? SpinKitRing(
                                                                          color:
                                                                              Colors.white,
                                                                          lineWidth:
                                                                              4,
                                                                          size:
                                                                              40,
                                                                        )
                                                                      : Text(
                                                                          "Add",
                                                                          style:
                                                                              normalTextWhite,
                                                                        ),
                                                                  onPressed:
                                                                      () async {
                                                                    if (_formKey
                                                                        .currentState
                                                                        .validate()) {
                                                                      setState(
                                                                          () {
                                                                        isLoading =
                                                                            true;
                                                                      });

                                                                      setState(
                                                                          () {
                                                                        isLoading =
                                                                            false;
                                                                      });
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
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
                                                  height: SizeConfig
                                                          .safeBlockVertical *
                                                      50,
                                                  child: Container(
                                                    width: SizeConfig
                                                            .safeBlockHorizontal *
                                                        100,
                                                    height: SizeConfig
                                                            .safeBlockVertical *
                                                        28,
                                                    child: Column(
                                                      children: [
                                                        Wrap(
                                                          children: actorWidgets
                                                              .toList(),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Form(
                                                            key: _formKey,
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  width: SizeConfig
                                                                          .screenWidth *
                                                                      0.9,
                                                                  height: SizeConfig
                                                                          .screenHeight *
                                                                      0.06,
                                                                  child:
                                                                      TextFormField(
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .number,
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
                                                                      if (int.parse(
                                                                              balance) <
                                                                          10) {
                                                                        return 'Please add minimum 10 Rupees';
                                                                      }
                                                                      return null;
                                                                    },
                                                                    cursorHeight:
                                                                        20,
                                                                    decoration: InputDecoration(
                                                                        enabledBorder: OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Colors.grey),
                                                                        ),
                                                                        focusedBorder: OutlineInputBorder(
                                                                          borderSide:
                                                                              BorderSide(color: Colors.blue),
                                                                        ),
                                                                        contentPadding: EdgeInsets.only(left: 10),
                                                                        hintText: "Amount",
                                                                        hintStyle: textFieldSize),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Container(
                                                                  width: SizeConfig
                                                                          .screenWidth *
                                                                      0.9,
                                                                  height: SizeConfig
                                                                          .screenHeight *
                                                                      0.06,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .blue,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(3),
                                                                  ),
                                                                  child:
                                                                      ElevatedButton(
                                                                    child: isLoading
                                                                        ? SpinKitRing(
                                                                            color:
                                                                                Colors.white,
                                                                            lineWidth:
                                                                                4,
                                                                            size:
                                                                                40,
                                                                          )
                                                                        : Text(
                                                                            "Add",
                                                                            style:
                                                                                normalTextWhite,
                                                                          ),
                                                                    onPressed:
                                                                        () async {
                                                                      if (_formKey
                                                                          .currentState
                                                                          .validate()) {
                                                                        setState(
                                                                            () {
                                                                          isLoading =
                                                                              true;
                                                                        });

                                                                        setState(
                                                                            () {
                                                                          isLoading =
                                                                              false;
                                                                        });
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
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
