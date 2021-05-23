import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devloperstudio/size_configuration.dart';
import 'package:devloperstudio/widgets/cpforum/forumModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuestionPostAndReplies extends StatefulWidget {
  @override
  _QuestionPostAndRepliesState createState() => _QuestionPostAndRepliesState();
}

class _QuestionPostAndRepliesState extends State<QuestionPostAndReplies> {
  String quesId = '';
  String userId = "";
  bool isLoading = false;
  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    userId = FirebaseAuth.instance.currentUser.uid;
    print(quesId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  CpForumModel model = new CpForumModel();
  int rating = -1;
  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    String questionId = routeArguments['questionId'];
    String askedBy = routeArguments['askedBy'];
    String questionTitle = routeArguments['questionTitle'];
    quesId = questionId;
    Future<String> getQuestionRating() async {
      CollectionReference updateForum =
          FirebaseFirestore.instance.collection('RateQuestion');
      await updateForum
          .doc(userId)
          .get()
          .then((value) => {rating = value.get(questionId), print(rating)})
          .catchError((e) {});
      return rating.toString();
    }

    Stream documentStream = FirebaseFirestore.instance
        .collection('CodingForum')
        .doc(questionId)
        .snapshots();
    Widget codinghilighter(BuildContext context, String finalCode) {
      return Container(
        width: SizeConfig.safeBlockHorizontal * 95,
        // height: SizeConfig.safeBlockVertical * 45,
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.blue,
          width: 2,
        )),
        child: SyntaxView(
            code: finalCode,
            syntax: Syntax.CPP,
            syntaxTheme: SyntaxTheme.dracula(),
            withZoom: true,
            withLinesCount: true),
      );
    }

    SizeConfig().init(context);
    Image appLogo = new Image(
        image: new ExactAssetImage("assets/logos/home_icon.png"),
        height: 100.0,
        width: 90.0,
        alignment: FractionalOffset.center);
    return FutureBuilder<String>(
        future: getQuestionRating(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.blue,
                child: Icon(Icons.reply_all_sharp),
                onPressed: () {
                  Navigator.of(context).pushNamed('/replyQuestion', arguments: {
                    'questionId': questionId,
                    'askedBy': askedBy,
                    'questionTitle': questionTitle,
                  });
                },
              ),
              backgroundColor: Colors.grey[50],
              appBar: AppBar(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                elevation: 10,
                title: appLogo,
              ),
              body: SafeArea(
                child: StreamBuilder<DocumentSnapshot>(
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
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundImage: snapshot.data
                                                      .get('ProfilePicLink') ==
                                                  null ||
                                              snapshot.data
                                                      .get('ProfilePicLink') ==
                                                  ""
                                          ? AssetImage(
                                              "assets/images/profile.jpg")
                                          : NetworkImage(snapshot.data
                                              .get('ProfilePicLink')),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          snapshot.data.get('AskedBy'),
                                          style: TextStyle(
                                            fontFamily: "OpenSans",
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        snapshot.data.get('Date'),
                                        style: TextStyle(
                                          fontFamily: "OpenSans",
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: Column(
                              //     children: [
                              //       GestureDetector(
                              //           onTap: () {
                              //             setState(() {
                              //               rating = 1;
                              //               model.rateQuestion(
                              //                   rating, userId, questionId);
                              //             });
                              //           },
                              //           child: rating == -1
                              //               ? Image.asset(
                              //                   "assets/images/mark_useful.png")
                              //               : rating == 1
                              //                   ? Image.asset(
                              //                       "assets/images/useful_marked.png")
                              //                   : Image.asset(
                              //                       "assets/images/mark_useful.png")),
                              //       Text(
                              //           snapshot.data.get('Useful').toString()),
                              //       GestureDetector(
                              //           onTap: () {
                              //             setState(() {
                              //               rating = 0;
                              //               model.rateQuestion(
                              //                   rating, userId, questionId);
                              //             });
                              //           },
                              //           child: rating == -1
                              //               ? Image.asset(
                              //                   "assets/images/mark_not_useful.png")
                              //               : rating == 0
                              //                   ? Image.asset(
                              //                       "assets/images/not_useful_marked.png")
                              //                   : Image.asset(
                              //                       "assets/images/mark_not_useful.png")),
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              snapshot.data.get('Title'),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: "OpenSans",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: codinghilighter(
                                context, snapshot.data.get('Code')),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              snapshot.data.get('Description'),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: "OpenSans",
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 3,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              snapshot.data.get('Replies').length.toString() +
                                  " Answers",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: "OpenSans",
                              ),
                            ),
                          ),
                          ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data.get('Replies').length,
                            itemBuilder: (BuildContext context, int ind) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              backgroundImage: snapshot.data.get(
                                                                  'Replies')[ind]
                                                              ['ProfileLink'] ==
                                                          null ||
                                                      snapshot.data.get(
                                                                  'Replies')[ind]
                                                              ['ProfileLink'] ==
                                                          ""
                                                  ? AssetImage(
                                                      "assets/images/profile.jpg")
                                                  : NetworkImage(snapshot.data
                                                          .get('Replies')[ind]
                                                      ['ProfileLink']),
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
                                                  snapshot.data
                                                          .get('Replies')[ind]
                                                      ['RepliedBy'],
                                                  style: TextStyle(
                                                    fontFamily: "OpenSans",
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                snapshot.data
                                                        .get('Replies')[ind]
                                                    ['Date'],
                                                style: TextStyle(
                                                  fontFamily: "OpenSans",
                                                  color: Colors.grey,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Column(
                                      //     children: [
                                      //       Image.asset(
                                      //           "assets/images/useful_marked.png"),
                                      //       Text(snapshot.data
                                      //           .get('Replies')[ind]
                                      //               ['Useful']
                                      //           .toString()),
                                      //       Image.asset(
                                      //           "assets/images/mark_not_useful.png"),
                                      //     ],
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  snapshot.data.get('Replies')[ind]['Code'] ==
                                              null ||
                                          snapshot.data.get('Replies')[ind]
                                                  ['Code'] ==
                                              ""
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: codinghilighter(
                                              context,
                                              snapshot.data.get('Replies')[ind]
                                                  ['Code']),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      snapshot.data.get('Replies')[ind]
                                          ['Explanation'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: "OpenSans",
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.grey,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Colors.grey[50],
              appBar: AppBar(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black),
                elevation: 10,
                title: appLogo,
              ),
              body: Center(
                child: SpinKitRing(
                  color: Colors.blue,
                  lineWidth: 4,
                  size: 40,
                ),
              ),
            );
          }
        });
  }
}
