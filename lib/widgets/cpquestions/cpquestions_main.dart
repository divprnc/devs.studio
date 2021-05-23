import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devloperstudio/size_configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CpQuestionsMainPage extends StatefulWidget {
  @override
  _CpQuestionsMainPageState createState() => _CpQuestionsMainPageState();
}

class _CpQuestionsMainPageState extends State<CpQuestionsMainPage> {
  List<dynamic> cpData = [
    "Array",
    "Recursion",
    "Hashing",
    "String",
    "Searching",
    "Sorting",
    "Linked List",
    "Circular Linked List",
    "Doubly Linked List",
    "Stack",
    "Queue",
    "Dequeue",
    "Tree",
    "Binary Search Tree",
    "Heap",
    "Graph",
    "Greedy",
    "Backtracking",
    "Dynamic Programming",
    "Trie",
    "Segment-Tree",
    "Disjoint Sets",
  ];
  Image appLogo = new Image(
      image: new ExactAssetImage("assets/logos/home_icon.png"),
      height: 100.0,
      width: 90.0,
      alignment: FractionalOffset.center);
  @override
  Widget build(BuildContext context) {
    CollectionReference quizes =
        FirebaseFirestore.instance.collection('QuestionsList');
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 10,
          title: appLogo,
        ),
        body: StreamBuilder<QuerySnapshot>(
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
                      "DSA Questions",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                      onTap: () {
                        String s = snapshot.data.docs[index].id;
                        List easy = snapshot.data.docs[index]["Easy"];
                        List medium = snapshot.data.docs[index]["Medium"];
                        List hard = snapshot.data.docs[index]["Hard"];
                        print(easy);
                        Navigator.of(context).pushNamed('/cpquestionslist',
                            arguments: {
                              'topicName': s,
                              'easy': easy,
                              'medium': medium,
                              'hard': hard
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8, left: 8, right: 8, bottom: 8),
                        child: Container(
                          height: SizeConfig.safeBlockVertical * 12,
                          width: SizeConfig.safeBlockHorizontal * 100,
                          color: Colors.grey[300],
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 30,
                                  child: Center(
                                    child: Text(
                                      "${snapshot.data.docs[index].id[0]}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "OpenSans",
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "${snapshot.data.docs[index].id}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontFamily: "OpenSans"),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
