import 'package:devloperstudio/size_configuration.dart';
import 'package:flutter/material.dart';

class JobPortalMain extends StatefulWidget {
  @override
  _JobPortalMainState createState() => _JobPortalMainState();
}

class _JobPortalMainState extends State<JobPortalMain> {
  @override
  Widget build(BuildContext context) {
    Image appLogo = new Image(
        image: new ExactAssetImage("assets/logos/home_icon.png"),
        height: 100.0,
        width: 90.0,
        alignment: FractionalOffset.center);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: appLogo,
      ),
      body: Column(
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
                height: SizeConfig.safeBlockVertical * 25,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   width: SizeConfig.safeBlockHorizontal * 15,
                    //   height: SizeConfig.safeBlockVertical * 7,
                    //   color: Colors.green,
                    // )
                    Row(
                      children: [
                        Image.network(
                          "https://cdn.freebiesupply.com/logos/large/2x/google-icon-logo-png-transparent.png",
                          width: SizeConfig.safeBlockHorizontal * 15,
                          height: SizeConfig.safeBlockVertical * 7,
                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal * 8,
                        ),
                        Text(
                          "Software Engineer - I",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: "OpenSans",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Icon(Icons.work),
                          SizedBox(
                            width: SizeConfig.safeBlockHorizontal * 8,
                          ),
                          Text(
                            "0 - 1 Years",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(
                            width: SizeConfig.safeBlockHorizontal * 8,
                          ),
                          Text(
                            "Bangalore, Karnataka",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontFamily: "OpenSans",
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical * 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: SizeConfig.safeBlockHorizontal * 60,
                          height: SizeConfig.safeBlockVertical * 5,
                          child: ElevatedButton(
                            child: Text(
                              "Apply",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0))),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal * 8,
                        ),
                        Icon(Icons.share_sharp),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
