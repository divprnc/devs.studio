import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devloperstudio/size_configuration.dart';
import 'package:devloperstudio/widgets/cpforum/ask_question.dart';
import 'package:devloperstudio/widgets/cpforum/my_posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:devloperstudio/theme.dart';

class CpForumMain extends StatefulWidget {
  @override
  _CpForumMainState createState() => _CpForumMainState();
}

class _CpForumMainState extends State<CpForumMain> {
  List<String> codings = [
    "C++",
    "C",
    "Java",
    "Python",
  ];
  Map<int, List<Color>> colorGradients = {
    1: [Colors.blueAccent, Colors.blue[300]],
    2: [Colors.blue[200], Colors.blue],
    3: [
      Colors.purple[200],
      Colors.purple[700],
    ],
    4: [Colors.teal[200], Colors.teal],
  };
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Widget scrollViewData(context, int index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: colorGradients[index],
              ),
              borderRadius: BorderRadius.circular(25)),
          width: SizeConfig.safeBlockHorizontal * 40,
          height: SizeConfig.safeBlockVertical * 15,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(codings[index],
                    style: normalTextWhite), // Posts, Replies,Comments
                // Text("10", style: normalTextWhite),
              ],
            ),
          ),
        ),
      );
    }

    CollectionReference quizes =
        FirebaseFirestore.instance.collection('CodingForum');
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   iconTheme: IconThemeData(color: Colors.black),
      //   elevation: 10,
      //   title: appLogo,
      //   actions: [
      //     Padding(
      //       padding: EdgeInsets.all(10),
      //       child: ElevatedButton(
      //         onPressed: () {
      //           Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      //             return AskQuestion();
      //           }));
      //         },
      //         child: Center(
      //           child: Text(
      //             "Ask Question",
      //             style: TextStyle(color: Colors.white, fontFamily: "OpenSans"),
      //           ),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        // child: Icon(Icons.post_add),
        icon: Icon(Icons.post_add_rounded),
        elevation: 10,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return AskQuestion();
          }));
        },
        label: Text("Ask Question"),
      ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Recent Posts",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: "OpenSans",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return MyPosts();
                            }));
                          },
                          child: Text(
                            "My Posts",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   height: SizeConfig.safeBlockVertical * 30,
                  //   width: SizeConfig.safeBlockHorizontal * 100,
                  //   child: ListView.builder(
                  //     physics: BouncingScrollPhysics(),
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     itemCount: codings.length,
                  //     itemBuilder: (BuildContext context, int index) =>
                  //         scrollViewData(context, index),
                  //   ),
                  // ),
                  ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        List getcontent = snapshot.data.docs[index]
                            .get('Description')
                            .split(' ');
                        String content = "";
                        if (getcontent.length > 40) {
                          for (int i = 0; i < 25; i++) {
                            content += getcontent[i] + " ";
                          }
                        } else {
                          content =
                              snapshot.data.docs[index].get('Description');
                        }
                        content += " ....";
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    '/questionPostAndReplies',
                                    arguments: {
                                      'questionId': snapshot.data.docs[index].id
                                          .toString(),
                                      'askedBy': snapshot.data.docs[index]
                                          .get('AskedBy')
                                          .toString(),
                                      'questionTitle': snapshot.data.docs[index]
                                          .get('Title')
                                          .toString(),
                                    });
                              },
                              child: Card(
                                elevation: 1,
                                child: Container(
                                  width: SizeConfig.safeBlockHorizontal * 90,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              backgroundImage: snapshot
                                                              .data.docs[index]
                                                              .get(
                                                                  'ProfilePicLink') ==
                                                          null ||
                                                      snapshot.data.docs[index].get(
                                                              'ProfilePicLink') ==
                                                          ""
                                                  ? AssetImage(
                                                      "assets/images/profile.jpg")
                                                  : NetworkImage(snapshot
                                                      .data.docs[index]
                                                      .get('ProfilePicLink')),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(
                                                  snapshot.data.docs[index]
                                                      .get('AskedBy'),
                                                  style: TextStyle(
                                                    fontFamily: "OpenSans",
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                snapshot.data.docs[index]
                                                    .get('Date'),
                                                style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 8,
                                        ),
                                        child: Text(
                                          snapshot.data.docs[index]
                                              .get('Title'),
                                          style: TextStyle(
                                            fontFamily: "OpenSans",
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 8,
                                        ),
                                        child: Text(
                                          content,
                                          style: TextStyle(
                                            fontFamily: "OpenSans",
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // color: Colors.black,
                                        width: SizeConfig.safeBlockHorizontal *
                                            100,
                                        height:
                                            SizeConfig.safeBlockVertical * 10,
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8,
                                            ),
                                            child: ListView.builder(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: snapshot.data
                                                    .docs[index]['Tags'].length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                            int ind) =>
                                                        Chip(
                                                          label: new Text(
                                                            snapshot.data
                                                                    .docs[index]
                                                                ['Tags'][ind],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .blue[900],
                                                                fontFamily:
                                                                    "OpenSans"),
                                                          ),
                                                          backgroundColor:
                                                              Colors.blue[50],
                                                        ))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          left: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              snapshot
                                                      .data
                                                      .docs[index]['Replies']
                                                      .length
                                                      .toString() +
                                                  " Replies",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                  fontFamily: "OpenSans"),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Icon(
                                              Icons.comment,
                                              color: Colors.blue,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ));
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
