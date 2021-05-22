import 'package:devloperstudio/size_configuration.dart';
import 'package:devloperstudio/theme.dart';
import 'package:flutter/material.dart';

class EbookMainPage extends StatefulWidget {
  @override
  _EbookMainPageState createState() => _EbookMainPageState();
}

class _EbookMainPageState extends State<EbookMainPage> {
  @override
  Widget build(BuildContext context) {
    Widget horizontalEbookui(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
              ),
              image: DecorationImage(
                  image: AssetImage("assets/images/cover_ebook.jpg"),
                  fit: BoxFit.cover),
              color: Colors.blue,
              borderRadius: BorderRadius.circular(25)),
          width: SizeConfig.safeBlockHorizontal * 40,
          height: SizeConfig.safeBlockVertical * 20,
        ),
      );
    }

    Widget horizontalTopicTags(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Chip(
          label: new Text(
            "Html and CSS",
            overflow: TextOverflow.ellipsis,
            style:
                new TextStyle(color: Colors.blue[900], fontFamily: "OpenSans"),
          ),
          backgroundColor: Colors.blue[50],
        ),
      );
    }

    Widget verticalBooksui(BuildContext context) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: SizeConfig.safeBlockHorizontal * 100,
              height: SizeConfig.safeBlockVertical * 30,
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Container(
                        width: SizeConfig.safeBlockHorizontal * 30,
                        height: SizeConfig.safeBlockVertical * 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/images/cover_ebook.jpg"),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: SizeConfig.safeBlockHorizontal * 60,
                      height: SizeConfig.safeBlockVertical * 28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 10,
                            ),
                            child: Text(
                              "Html and Css",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontFamily: "OpenSans"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 10,
                            ),
                            child: Text(
                              "Divyanshu Bhaskar",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  fontFamily: "OpenSans"),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 5,
                              left: 10,
                            ),
                            width: SizeConfig.screenWidth,
                            child: new Column(
                              children: <Widget>[
                                Text(
                                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum.",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                      fontFamily: "OpenSans"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            height: 10,
          ),
        ],
      );
    }

    SizeConfig().init(context);
    Image appLogo = new Image(
        image: new ExactAssetImage("assets/logos/home_icon.png"),
        height: 100.0,
        width: 90.0,
        alignment: FractionalOffset.center);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 10,
        title: appLogo,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Devloper Studio Ebooks", style: newProfile),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: SizeConfig.safeBlockVertical * 35,
                width: SizeConfig.safeBlockHorizontal * 100,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) =>
                      horizontalEbookui(context),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Categories", style: newProfile),
              ),
              Container(
                height: SizeConfig.safeBlockVertical * 8,
                width: SizeConfig.safeBlockHorizontal * 100,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) =>
                      horizontalTopicTags(context),
                ),
              ),
              ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) =>
                    verticalBooksui(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
