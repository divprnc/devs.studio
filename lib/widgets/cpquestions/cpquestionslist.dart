import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devloperstudio/size_configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';

class CpQuestionsLists extends StatefulWidget {
  @override
  _CpQuestionsListsState createState() => _CpQuestionsListsState();
}

class _CpQuestionsListsState extends State<CpQuestionsLists> {
  @override
  Widget build(BuildContext context) {
    final routeArguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    String topicName = routeArguments['topicName'];
    List easy = routeArguments['easy'];
    List medium = routeArguments['medium'];
    List hard = routeArguments['hard'];
    print(easy);
    Image appLogo = new Image(
        image: new ExactAssetImage("assets/logos/home_icon.png"),
        height: 100.0,
        width: 90.0,
        alignment: FractionalOffset.center);

    SizeConfig().init(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 3,
          title: appLogo,
          bottom: TabBar(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            isScrollable: true,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.blue,
            tabs: [
              Tab(
                text: "Easy",
              ),
              Tab(
                text: "Medium",
              ),
              Tab(
                text: "Hard",
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          widgetEasy(context, easy),
          widgetMedium(context, medium),
          widgetHard(context, hard),
        ]),
      ),
    );
  }

  Widget widgetEasy(BuildContext context, List easy) {
    return Padding(
        padding: const EdgeInsets.only(
          top: 12,
        ),
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: easy.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          color: Colors.blue.shade50,
                          width: SizeConfig.blockSizeHorizontal * 95,
                          height: SizeConfig.blockSizeVertical * 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_right_alt_outlined),
                              ),
                              Text(
                                easy[index]["Ques"]["Name"],
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20,
                                    fontFamily: "OpenSans"),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Share.share(easy[index]["Ques"]["Name"] +
                                      "\n" +
                                      easy[index]["Ques"]["Link"]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Icon(
                                    Icons.screen_share_outlined,
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ));
  }

  Widget widgetMedium(BuildContext context, List easy) {
    return Padding(
        padding: const EdgeInsets.only(
          top: 12,
        ),
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: easy.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          color: Colors.blue.shade50,
                          width: SizeConfig.blockSizeHorizontal * 95,
                          height: SizeConfig.blockSizeVertical * 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_right_alt_outlined),
                              ),
                              Text(
                                easy[index]["Ques"]["Name"],
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20,
                                    fontFamily: "OpenSans"),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Share.share(easy[index]["Ques"]["Name"] +
                                      "\n" +
                                      easy[index]["Ques"]["Link"]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Icon(
                                    Icons.screen_share_outlined,
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ));
  }

  Widget widgetHard(BuildContext context, List easy) {
    return Padding(
        padding: const EdgeInsets.only(
          top: 12,
        ),
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: easy.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Container(
                          color: Colors.blue.shade50,
                          width: SizeConfig.blockSizeHorizontal * 95,
                          height: SizeConfig.blockSizeVertical * 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_right_alt_outlined),
                              ),
                              Text(
                                easy[index]["Ques"]["Name"],
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontSize: 20,
                                    fontFamily: "OpenSans"),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Share.share(easy[index]["Ques"]["Name"] +
                                      "\n" +
                                      easy[index]["Ques"]["Link"]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Icon(
                                    Icons.screen_share_outlined,
                                    color: Colors.blue.shade900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ));
  }
}
