import 'package:devloperstudio/size_configuration.dart';
import 'package:flutter/material.dart';

class LiveCodingContests extends StatefulWidget {
  @override
  _LiveCodingContestsState createState() => _LiveCodingContestsState();
}

class _LiveCodingContestsState extends State<LiveCodingContests> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Image appLogo = new Image(
        image: new ExactAssetImage("assets/logos/home_icon.png"),
        height: 100.0,
        width: 90.0,
        alignment: FractionalOffset.center);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 10,
          title: appLogo,
          bottom: TabBar(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            isScrollable: true,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.blue,
            tabs: [
              Tab(
                text: "Codechef",
              ),
              Tab(
                text: "CodeForces",
              ),
              Tab(
                text: "HackerEarth",
              ),
              Tab(
                text: "HackerRank",
              ),
              Tab(
                text: "Leetcode",
              )
            ],
          ),
        ),
        body: TabBarView(children: [
          widgetCodeChef(context),
          widgetCodeForce(context),
          widgetHackerEarth(context),
          widgetHackerRank(context),
          widgetLeetCode(context),
        ]),
      ),
    );
  }

  Widget widgetCodeChef(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Recent Jobs",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: "OpenSans",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            child: Container(
              margin: EdgeInsets.all(10),
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    "https://miro.medium.com/max/15000/1*00C_a6JMPYeLdFyx0g28aQ.png",
                    width: SizeConfig.safeBlockHorizontal * 30,
                    height: SizeConfig.safeBlockVertical * 8,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Educational Codeforces Round 109 (Rated for Div. 2)",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "May/16/2021 13:30UTC+5.5",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Length:  02:00",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.alarm,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Set Remainder",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "OpenSans",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget widgetCodeForce(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Recent Jobs",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: "OpenSans",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            child: Container(
              margin: EdgeInsets.all(10),
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Codeforces_logo.svg/512px-Codeforces_logo.svg.png",
                    width: SizeConfig.safeBlockHorizontal * 30,
                    height: SizeConfig.safeBlockVertical * 4,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Educational Codeforces Round 109 (Rated for Div. 2)",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "May/16/2021 13:30UTC+5.5",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Length:  02:00",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.alarm,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Set Remainder",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "OpenSans",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget widgetHackerEarth(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Recent Jobs",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: "OpenSans",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            child: Container(
              margin: EdgeInsets.all(10),
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    "https://theme.zdassets.com/theme_assets/2151600/6c1b39b9428fa7302effd6774e950f1f3955cfa0.png",
                    width: SizeConfig.safeBlockHorizontal * 30,
                    height: SizeConfig.safeBlockVertical * 4,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Educational Codeforces Round 109 (Rated for Div. 2)",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "May/16/2021 13:30UTC+5.5",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Length:  02:00",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.alarm,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Set Remainder",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "OpenSans",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget widgetHackerRank(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Recent Jobs",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: "OpenSans",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            child: Container(
              margin: EdgeInsets.all(10),
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 29,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    "https://i0.wp.com/gradsingames.com/wp-content/uploads/2016/05/856771_668224053197841_1943699009_o.png",
                    width: SizeConfig.safeBlockHorizontal * 30,
                    height: SizeConfig.safeBlockVertical * 5,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Educational Codeforces Round 109 (Rated for Div. 2)",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "May/16/2021 13:30UTC+5.5",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Length:  02:00",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.alarm,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Set Remainder",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "OpenSans",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget widgetLeetCode(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Recent Jobs",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontFamily: "OpenSans",
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            child: Container(
              margin: EdgeInsets.all(10),
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 29,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    "https://miro.medium.com/max/724/1*izVQIUjPIk1XoqWj3VaiKg.png",
                    width: SizeConfig.safeBlockHorizontal * 30,
                    height: SizeConfig.safeBlockVertical * 5,
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Educational Codeforces Round 109 (Rated for Div. 2)",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "May/16/2021 13:30UTC+5.5",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Length:  02:00",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.safeBlockVertical * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.alarm,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Set Remainder",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: "OpenSans",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
