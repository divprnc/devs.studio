import 'package:devloperstudio/size_configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedLeaderboard extends StatefulWidget {
  @override
  _DetailedLeaderboardState createState() => _DetailedLeaderboardState();
}

class _DetailedLeaderboardState extends State<DetailedLeaderboard> {
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
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 10,
        title: appLogo,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                color: Colors.blue.shade50,
                width: SizeConfig.safeBlockHorizontal * 100,
                height: SizeConfig.safeBlockVertical * 14,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/profile.jpg"),
                            radius: 25,
                          ),
                        ),
                        Text(
                          "Divyanshu Bhaskar",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Rank:   2",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "score:   20",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Winning Amount:   ₹10",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
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
