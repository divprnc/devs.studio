import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devloperstudio/size_configuration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  String userId = "";
  bool isLoading = false;
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
    Image appLogo = new Image(
        image: new ExactAssetImage("assets/logos/home_icon.png"),
        height: 100.0,
        width: 90.0,
        alignment: FractionalOffset.center);

    CollectionReference quizes =
        FirebaseFirestore.instance.collection('CodingForum');
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: appLogo,
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "My Posts",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: "OpenSans",
                      ),
                    ),
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
                        if (snapshot.data.docs[index].get('AskedById') ==
                            userId) {
                          return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      '/questionPostAndReplies',
                                      arguments: {
                                        'questionId': snapshot
                                            .data.docs[index].id
                                            .toString(),
                                        'askedBy': snapshot.data.docs[index]
                                            .get('AskedBy')
                                            .toString(),
                                        'questionTitle': snapshot
                                            .data.docs[index]
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                backgroundImage: snapshot.data
                                                                .docs[index]
                                                                .get(
                                                                    'ProfilePicLink') ==
                                                            null ||
                                                        snapshot.data
                                                                .docs[index]
                                                                .get(
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
                                                  padding:
                                                      const EdgeInsets.only(
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
                                          width:
                                              SizeConfig.safeBlockHorizontal *
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
                                                  itemCount: snapshot
                                                      .data
                                                      .docs[index]['Tags']
                                                      .length,
                                                  itemBuilder: (BuildContext
                                                              context,
                                                          int ind) =>
                                                      Chip(
                                                        label: new Text(
                                                          snapshot.data
                                                                  .docs[index]
                                                              ['Tags'][ind],
                                                          overflow: TextOverflow
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
                        } else {
                          return Container();
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
