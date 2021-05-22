import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devloperstudio/size_configuration.dart';
import 'package:devloperstudio/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainHomePage extends StatefulWidget {
  @override
  _MainHomePageState createState() => _MainHomePageState();
}

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
                    "Play before ",
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
                              color: Colors.blue[900], fontFamily: "OpenSans"),
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
                  "Join Contest",
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Colors.white,
                      fontSize: 20),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/quizDetails', arguments: {
                    'quizId': documentSnapshot.id.toString().toString()
                  });
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

class _MainHomePageState extends State<MainHomePage> {
  bool isLoading = false;
  String userId;
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
                    child: Text("Live Quizes", style: drawerStyle),
                  ),
                  ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        String date = DateFormat("yyyy-MM-dd HH:mm:ss")
                            .format(DateTime.now());
                        String cdate = snapshot.data.docs[index].get('Date');
                        List dater = cdate.split("/").reversed.toList();
                        String finalDate = dater.join('-');
                        String ctime = snapshot.data.docs[index]
                            .get('Time')
                            .toString()
                            .toUpperCase();
                        String temptime =
                            DateFormat.jm().parse(ctime).toString();
                        List splitTime = temptime.split(" ");
                        String finalDateAndTime =
                            finalDate + " " + splitTime[1];
                        int compare = DateTime.parse(finalDateAndTime)
                            .difference(DateTime.parse(date))
                            .inSeconds;
                        if (compare < 0) {
                          return Container();
                        } else {
                          if (snapshot.data.docs[index]
                                  .get("Participants")
                                  .length >
                              0) {
                            for (int i = 0;
                                i <
                                    snapshot.data.docs[index]
                                        .get("Participants")
                                        .length;
                                i++) {
                              if (snapshot.data.docs[index]
                                      .get("Participants")[i]["UserId"] ==
                                  userId) {
                                print(userId);
                                return Container();
                              } else {
                                return quizDetailswidget(
                                    context, snapshot.data.docs[index]);
                              }
                            }
                          }
                          return quizDetailswidget(
                              context, snapshot.data.docs[index]);
                        }
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
