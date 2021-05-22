import 'package:devloperstudio/widgets/authorization/loginModel.dart';
import 'package:flutter/material.dart';
import 'package:devloperstudio/size_configuration.dart';
import 'package:devloperstudio/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  LoginModel loginModel = new LoginModel();
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _email = '', _password = '';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: SizeConfig.screenHeight * 0.08,
            left: SizeConfig.screenWidth * 0.25,
            child: Container(
              height: SizeConfig.safeBlockVertical * 6,
              width: SizeConfig.safeBlockHorizontal * 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logos/devloperstudio.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.02,
          // ),
          Positioned(
            top: SizeConfig.screenHeight * 0.18,
            left: SizeConfig.screenWidth * 0.30,
            child: Text(
              "Create an account",
              style: normalText,
            ),
          ),
          Positioned(
            top: SizeConfig.screenHeight * 0.33,
            left: SizeConfig.screenWidth * 0.1,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    width: SizeConfig.screenWidth * 0.8,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      validator: (email) {
                        if (email.isEmpty) {
                          return 'Please Enter a valid Email';
                        }
                        return null;
                      },
                      cursorHeight: 20,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText: "Email Address",
                          hintStyle: textFieldSize),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.8,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                      validator: (value) => value.length < 8
                          ? 'Enter the password minimum 8 characters'
                          : null,
                      obscureText: true,
                      cursorHeight: 20,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText: "Password",
                          hintStyle: textFieldSize),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.8,
                    height: SizeConfig.screenHeight * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: ElevatedButton(
                      child: isLoading
                          ? SpinKitRing(
                              color: Colors.white,
                              lineWidth: 4,
                              size: 40,
                            )
                          : Text(
                              "Sign Up",
                              style: normalTextWhite,
                            ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          await loginModel
                              .signupUsingEmailIdAndPassword(_email, _password)
                              .then((value) => {
                                loginModel.createUserProfile(),
                                Navigator.of(context).pop()})
                              .catchError((e) => {print(e)});
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Already have an account? ",
                        style: textFieldSize,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
