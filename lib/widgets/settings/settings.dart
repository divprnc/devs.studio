import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Image appLogo = new Image(
      image: new ExactAssetImage("assets/logos/home_icon.png"),
      height: 100.0,
      width: 90.0,
      alignment: FractionalOffset.center);
  @override
  Widget build(BuildContext context) {
    // SizeConfig.init();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blue),
        title: appLogo,
      ),
      body: Center(
        child: Text("Under Development"),
      ),
    );
  }
}
