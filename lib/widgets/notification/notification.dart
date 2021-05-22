import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../size_configuration.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  Image appLogo = new Image(
      image: new ExactAssetImage("assets/logos/home_icon.png"),
      height: 100.0,
      width: 90.0,
      alignment: FractionalOffset.center);
  String userName = "", userProfilePic, userId = '';
  bool isLoading = false;
  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    userName = FirebaseAuth.instance.currentUser.displayName;
    userProfilePic = FirebaseAuth.instance.currentUser.photoURL;
    userId = FirebaseAuth.instance.currentUser.uid;
    if (userName == "" || userName == null) {
      userName = "Anonymous";
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    Stream documentStream = FirebaseFirestore.instance
        .collection('Notifications')
        .doc(userId)
        .snapshots();
    SizeConfig().init(context);
    // SizeConfig.init();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: appLogo,
      ),
      body: SafeArea(
          child: StreamBuilder<DocumentSnapshot>(
        stream: documentStream,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            Fluttertoast.showToast(
                msg: "Something went wrong", toastLength: Toast.LENGTH_LONG);
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
          return SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.get('Notification').length,
                itemBuilder: (BuildContext context, int ind) {
                  String question =
                      snapshot.data.get('Notification')[ind]['QuestionTitle'];
                  String finalQues = '';
                  if (question.length > 50) {
                    for (int i = 0; i < 45; i++) {
                      finalQues += question[i];
                    }
                  }
                  finalQues += '......';
                  return Container(
                    padding: const EdgeInsets.all(12),
                    width: SizeConfig.screenWidth,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  snapshot.data.get('Notification')[ind]
                                                  ["RepliedByPic"] ==
                                              null ||
                                          snapshot.data.get('Notification')[ind]
                                                  ["RepliedByPic"] ==
                                              ""
                                      ? AssetImage("assets/images/profile.jpg")
                                      : NetworkImage(
                                          snapshot.data.get('Notification')[ind]
                                              ["RepliedByPic"]),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: RichText(
                                    text: TextSpan(children: [
                              TextSpan(
                                text: snapshot.data.get('Notification')[ind]
                                    ['RepliedByName'],
                                style: TextStyle(
                                  fontFamily: "OpenSans",
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: " replied to your post ",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: finalQues,
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ])))
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          );
        },
      )),
    );
  }
}
