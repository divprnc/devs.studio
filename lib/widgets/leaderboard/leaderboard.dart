import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devloperstudio/size_configuration.dart';
import 'package:devloperstudio/theme.dart';
import 'package:devloperstudio/widgets/leaderboard/detailedLeaderboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class LeaderBoard extends StatefulWidget {
  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  Widget quizDetailswidget(
      BuildContext context, DocumentSnapshot documentSnapshot) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Container(
          margin: EdgeInsets.all(10),
          width: SizeConfig.safeBlockHorizontal * 100,
          height: SizeConfig.safeBlockVertical * 26,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                width: SizeConfig.safeBlockHorizontal * 100,
                height: SizeConfig.safeBlockVertical * 5,
                child: Text(
                  documentSnapshot.get('Name').toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: "OpenSans"),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: SizeConfig.safeBlockHorizontal * 100,
                height: SizeConfig.safeBlockVertical * 5,
                child: Row(
                  children: [
                    Text(
                      "Game Ended On ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      documentSnapshot.get('Date'),
                      style: TextStyle(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      documentSnapshot.get('Time'),
                      style: homeText,
                    )
                  ],
                ),
              ),
              Container(
                width: SizeConfig.safeBlockHorizontal * 100,
                height: SizeConfig.safeBlockVertical * 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                  ),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: documentSnapshot.get('Tags').length,
                    itemBuilder: (BuildContext context, int index) => Row(
                      children: [
                        Chip(
                          label: new Text(
                            documentSnapshot.get('Tags')[index],
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                                color: Colors.blue[900],
                                fontFamily: "OpenSans"),
                          ),
                          backgroundColor: Colors.blue[50],
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: SizeConfig.safeBlockHorizontal * 100,
                height: SizeConfig.safeBlockVertical * 5,
                child: Row(
                  children: [
                    Text(
                      "Price",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: "OpenSans"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "₹ ${documentSnapshot.get('Price')}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: "OpenSans"),
                    ),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.safeBlockHorizontal * 92,
                height: SizeConfig.safeBlockVertical * 5,
                child: ElevatedButton(
                  child: Text(
                    "See Results and Winnings",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        color: Colors.white,
                        fontSize: 19),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return DetailedLeaderboard();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference quizes =
        FirebaseFirestore.instance.collection('LiveQuizes');
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: quizes.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 15,
                    ),
                    child: Text("Quiz Leaderboard", style: drawerStyle),
                  ),
                  ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return quizDetailswidget(
                            context, snapshot.data.docs[index]);
                      }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
