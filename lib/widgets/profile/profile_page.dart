import 'package:devloperstudio/size_configuration.dart';
import 'package:devloperstudio/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:multi_charts/multi_charts.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List options = ["Total Posts, Account Details,"];
  bool isLoading = false;
  String userEmail = "", fullEmail = "", userName = "", userProfilePic = "";
  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    userEmail = FirebaseAuth.instance.currentUser.email;
    userName = FirebaseAuth.instance.currentUser.displayName;
    userProfilePic = FirebaseAuth.instance.currentUser.photoURL;
    if (userName == "" || userName == null) {
      userName = "Developer.Studio";
    }
    fullEmail = userEmail;
    List data = userEmail.split('@');
    userEmail = "@${data[0]}";
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Widget profileName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        height: SizeConfig.safeBlockVertical * 5,
        width: double.infinity,
        child: Text(
          userName,
          style: dashboard,
        ),
      ),
    );
  }

  Widget dashboardGraph(BuildContext context) {
    return PieChart(
      size: Size(250, 250),
      values: [15, 10, 30, 25],
      labels: [
        "Total Contest",
        "Contest Played",
        "Money Invested",
        "Money Won"
      ],
      sliceFillColors: [
        Colors.blue[100],
        Colors.green[100],
        Colors.red[100],
        Colors.orange[100],
      ],
      animationDuration: Duration(milliseconds: 1500),
      legendPosition: LegendPosition.Right,
    );
  }

  Widget scrollViewData(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(25)),
        width: SizeConfig.safeBlockHorizontal * 40,
        height: SizeConfig.safeBlockVertical * 25,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Total Posts",
                  style: normalTextWhite), // Posts, Replies,Comments
              Text("10", style: normalTextWhite),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Image appLogo = new Image(
        image: new ExactAssetImage("assets/logos/home_icon.png"),
        height: 100.0,
        width: 90.0,
        alignment: FractionalOffset.center);
    Image winner = new Image(
        image: new ExactAssetImage("assets/logos/winner.png"),
        // height: 100.0,
        // width: 90.0,
        alignment: FractionalOffset.center);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: appLogo,
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: CircleAvatar(
              backgroundImage: userProfilePic == null || userProfilePic == ""
                  ? AssetImage("assets/images/profile.jpg")
                  : NetworkImage(userProfilePic),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? SpinKitRing(
                color: Colors.blue,
                lineWidth: 4,
                size: 40,
              )
            : Container(
                child: Column(
                  children: [
                    profileName(context),
                    Container(
                      width: SizeConfig.safeBlockHorizontal * 100,
                      height: SizeConfig.safeBlockVertical * 5,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Dashboard",
                          style: newProfile,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 60, left: 10, bottom: 20),
                      child: dashboardGraph(context),
                    ),
                    // Container(
                    //   height: SizeConfig.safeBlockVertical * 35,
                    //   width: SizeConfig.safeBlockHorizontal * 100,
                    //   child: ListView.builder(
                    //     physics: BouncingScrollPhysics(),
                    //     shrinkWrap: true,
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: 3,
                    //     itemBuilder: (BuildContext context, int index) =>
                    //         scrollViewData(context),
                    //   ),
                    // )
                    Column(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.email_outlined,
                            color: Colors.blue,
                          ),
                          title: Text(
                            fullEmail,
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.my_library_books,
                            color: Colors.blue,
                          ),
                          title: Text(
                            "Total Posts",
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            "10",
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          leading: winner,
                          title: Text(
                            "Quiz Won",
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            "1",
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Colors.blue,
                          ),
                          title: Text(
                            "Account Details",
                            style: TextStyle(
                                fontFamily: "OpenSans",
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: ElevatedButton(
                            child: Text(
                              "Update",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 40,
                                      child: Container(
                                        height:
                                            SizeConfig.safeBlockVertical * 52,
                                        child: Column(
                                          children: [
                                            Text(
                                              "Update Account Details",
                                              style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              // width: SizeConfig.safeBlockHorizontal *
                                              //     100,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Form(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Upi Id",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "OpenSans",
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextField(
                                                          cursorHeight: 20,
                                                          decoration:
                                                              InputDecoration(
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.grey),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.blue),
                                                                  ),
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          left:
                                                                              10),
                                                                  hintText:
                                                                      "Upi Id",
                                                                  hintStyle:
                                                                      textFieldSize)),
                                                      Text(
                                                        "Account Number",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "OpenSans",
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextField(
                                                          cursorHeight: 20,
                                                          decoration:
                                                              InputDecoration(
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.grey),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.blue),
                                                                  ),
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          left:
                                                                              10),
                                                                  hintText:
                                                                      "Account Number",
                                                                  hintStyle:
                                                                      textFieldSize)),
                                                      Text(
                                                        "IFSC Code",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "OpenSans",
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextField(
                                                          cursorHeight: 20,
                                                          decoration:
                                                              InputDecoration(
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.grey),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.blue),
                                                                  ),
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          left:
                                                                              10),
                                                                  hintText:
                                                                      "IFSC Code",
                                                                  hintStyle:
                                                                      textFieldSize)),
                                                      Text(
                                                        "Account Holder Name",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "OpenSans",
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      TextField(
                                                          cursorHeight: 20,
                                                          decoration:
                                                              InputDecoration(
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.grey),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                            color:
                                                                                Colors.blue),
                                                                  ),
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          left:
                                                                              10),
                                                                  hintText:
                                                                      "Account Holder Name",
                                                                  hintStyle:
                                                                      textFieldSize)),
                                                      Container(
                                                        width: SizeConfig
                                                                .blockSizeHorizontal *
                                                            100,
                                                        child: ElevatedButton(
                                                          onPressed: () {},
                                                          child: Text(
                                                            "Update",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "OpenSans",
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
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
                                      ),
                                    );
                                  });
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
