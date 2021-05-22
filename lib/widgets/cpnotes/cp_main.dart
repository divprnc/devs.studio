import 'package:devloperstudio/size_configuration.dart';
import 'package:flutter/material.dart';

class CpMainPage extends StatefulWidget {
  @override
  _CpMainPageState createState() => _CpMainPageState();
}

class _CpMainPageState extends State<CpMainPage> {
  List<dynamic> cpData = [
    "Analysis of Algorithms",
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Image appLogo = new Image(
        image: new ExactAssetImage("assets/logos/home_icon.png"),
        height: 100.0,
        width: 90.0,
        alignment: FractionalOffset.center);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 10,
        title: appLogo,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Comptetive Programming",
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
              itemCount: cpData.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  // Navigator.of(context).pushNamed('/cpexpanded',
                  //     arguments: {'topicName': cpData[index].toString()});
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 8, right: 8, bottom: 8),
                  child: Container(
                    height: SizeConfig.safeBlockVertical * 12,
                    width: SizeConfig.safeBlockHorizontal * 100,
                    color: Colors.lightBlue[50],
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 30,
                            child: Center(
                              child: Text(
                                "${cpData[index][0]}",
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
                          "${cpData[index]}",
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
      ),
    );
  }
}
