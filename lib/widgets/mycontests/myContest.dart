import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:devloperstudio/theme.dart';
import 'package:devloperstudio/size_configuration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyContests extends StatefulWidget {
  @override
  _MyContestsState createState() => _MyContestsState();
}

class _MyContestsState extends State<MyContests> {
  bool isLoading = false;
  double containerWidth = SizeConfig.blockSizeVertical * 100;
  double containerHeight = SizeConfig.blockSizeVertical * 7;
  String userId;
  Stream pastQuizes;
  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    userId = FirebaseAuth.instance.currentUser.uid;
    pastQuizes = FirebaseFirestore.instance
        .collection('UserProfile')
        .doc(userId)
        .snapshots();
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
    SizeConfig().init(context);
    return Scaffold(
      body: isLoading
          ? Center(
              child: SpinKitRing(
                color: Colors.blue,
                lineWidth: 4,
                size: 40,
              ),
            )
          : SafeArea(
              child: StreamBuilder<DocumentSnapshot>(
                  stream: pastQuizes,
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      Fluttertoast.showToast(
                          msg: "Something went wrong",
                          toastLength: Toast.LENGTH_LONG);
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // return Container();
                      return Center(
                        child: SpinKitRing(
                          color: Colors.blue,
                          lineWidth: 4,
                          size: 40,
                        ),
                      );
                    } else {
                      // print(snapshot.data.data());
                      return SingleChildScrollView(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 10,
                              ),
                              child: Text("Participated Contests",
                                  style: drawerStyle),
                            ),
                            ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    snapshot.data.get("Participated").length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: Colors.grey[200],
                                      elevation: 5,
                                      child: ExpandablePanel(
                                        header: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              snapshot.data.get("Participated")[
                                                      index]["QuizName"] +
                                                  "\t\t: " +
                                                  snapshot.data.get(
                                                          "Participated")[index]
                                                      ["DateAndTime"] +
                                                  "\n" +
                                                  "Total Marks : " +
                                                  snapshot.data
                                                      .get("Participated")[
                                                          index]["TotalMarks"]
                                                      .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "OpenSans",
                                                  fontSize: 18),
                                            )),
                                        expanded: Column(
                                          children: [
                                            ListView.builder(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: snapshot.data
                                                    .get("Participated")[index]
                                                        ["QuestionTimings"]
                                                    .length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int ind) {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Text(
                                                          "Question ${ind + 1}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  "OpenSans",
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "Seconds : " +
                                                              snapshot.data
                                                                  .get("Participated")[
                                                                      index][
                                                                      "QuestionTimings"]
                                                                      [ind]
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "OpenSans",
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                })
                                          ],
                                        ),
                                        builder: (_, collapsed, expanded) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                                bottom: 10.0),
                                            child: Expandable(
                                              collapsed: collapsed,
                                              expanded: expanded,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                  // return GestureDetector(
                                  //   onTap: () {
                                  //     setState(() {
                                  //       containerHeight = containerHeight ==
                                  //               SizeConfig.blockSizeVertical * 7
                                  //           ? SizeConfig.blockSizeVertical * 58
                                  //           : SizeConfig.blockSizeVertical * 7;
                                  //       containerWidth = containerWidth ==
                                  //               SizeConfig.blockSizeVertical *
                                  //                   100
                                  //           ? SizeConfig.blockSizeVertical * 100
                                  //           : SizeConfig.blockSizeVertical *
                                  //               100;
                                  //     });
                                  //   },
                                  //   child: Card(
                                  //     elevation: 5,
                                  //     child: AnimatedContainer(
                                  //       duration: Duration(milliseconds: 600),
                                  //       color: Colors.grey[200],
                                  //       width: containerWidth,
                                  //       height: containerHeight,
                                  //       child: Column(
                                  //         children: [
                                  //           Padding(
                                  //             padding: const EdgeInsets.only(
                                  //                 top: 15),
                                  //             child: Row(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment
                                  //                       .spaceBetween,
                                  //               children: [
                                  //                 Padding(
                                  //                   padding:
                                  //                       const EdgeInsets.only(
                                  //                           left: 8, right: 8),
                                  //                   child: Text(
                                  //                     snapshot.data.data()[
                                  //                             "Participated"]
                                  //                         [index]["QuizName"],
                                  //                     style: TextStyle(
                                  //                         fontWeight:
                                  //                             FontWeight.bold,
                                  //                         fontFamily:
                                  //                             "OpenSans",
                                  //                         fontSize: 18),
                                  //                   ),
                                  //                 ),
                                  //                 Padding(
                                  //                   padding:
                                  //                       const EdgeInsets.only(
                                  //                           left: 8, right: 8),
                                  //                   child: Text(
                                  //                     "Total Marks : " +
                                  //                         snapshot.data
                                  //                             .data()[
                                  //                                 "Participated"]
                                  //                                 [index]
                                  //                                 ["TotalMarks"]
                                  //                             .toString(),
                                  //                     style: TextStyle(
                                  //                         fontWeight:
                                  //                             FontWeight.bold,
                                  //                         fontFamily:
                                  //                             "OpenSans",
                                  //                         fontSize: 18),
                                  //                   ),
                                  //                 ),
                                  //                 Icon(Icons
                                  //                     .arrow_drop_down_outlined),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //           Expanded(
                                  //             child: SingleChildScrollView(
                                  //               child: Column(
                                  //                 children: [
                                  //                   ListView.builder(
                                  //                       physics:
                                  //                           BouncingScrollPhysics(),
                                  //                       shrinkWrap: true,
                                  //                       scrollDirection:
                                  //                           Axis.vertical,
                                  //                       itemCount: snapshot.data
                                  //                           .data()[
                                  //                               "Participated"]
                                  //                               [index][
                                  //                               "QuestionTimings"]
                                  //                           .length,
                                  //                       itemBuilder:
                                  //                           (BuildContext
                                  //                                   context,
                                  //                               int ind) {
                                  //                         return Row(
                                  //                           mainAxisAlignment:
                                  //                               MainAxisAlignment
                                  //                                   .spaceBetween,
                                  //                           children: [
                                  //                             Padding(
                                  //                               padding:
                                  //                                   const EdgeInsets
                                  //                                           .only(
                                  //                                       left: 8,
                                  //                                       right:
                                  //                                           8),
                                  //                               child: Text(
                                  //                                 "Question ${ind + 1}",
                                  //                                 style: TextStyle(
                                  //                                     fontWeight:
                                  //                                         FontWeight
                                  //                                             .bold,
                                  //                                     fontFamily:
                                  //                                         "OpenSans",
                                  //                                     fontSize:
                                  //                                         18),
                                  //                               ),
                                  //                             ),
                                  //                             Padding(
                                  //                               padding:
                                  //                                   const EdgeInsets
                                  //                                           .all(
                                  //                                       8.0),
                                  //                               child: Text(
                                  //                                 "Seconds : " +
                                  //                                     snapshot
                                  //                                         .data
                                  //                                         .data()[
                                  //                                             "Participated"]
                                  //                                             [
                                  //                                             index]
                                  //                                             [
                                  //                                             "QuestionTimings"]
                                  //                                             [
                                  //                                             ind]
                                  //                                         .toString(),
                                  //                                 style: TextStyle(
                                  //                                     fontWeight:
                                  //                                         FontWeight
                                  //                                             .w500,
                                  //                                     fontFamily:
                                  //                                         "OpenSans",
                                  //                                     fontSize:
                                  //                                         18),
                                  //                               ),
                                  //                             ),
                                  //                           ],
                                  //                         );
                                  //                       })
                                  //                 ],
                                  //               ),
                                  //             ),
                                  //           )
                                  //         ],
                                  //       ),
                                  //     ),
                                  //   ),
                                  // );
                                }),
                          ],
                        ),
                      );
                    }
                  }),
            ),
    );
  }
}
