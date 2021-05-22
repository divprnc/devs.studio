import 'package:devloperstudio/widgets/authorization/signup.dart';
import 'package:devloperstudio/widgets/mainpage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:devloperstudio/size_configuration.dart';
import 'package:devloperstudio/theme.dart';
import './loginModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      body: isLoading
          ? Center(
              child: SpinKitRing(
                color: Colors.blue,
                lineWidth: 4,
                size: 40,
              ),
            )
          : Stack(
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
                  left: SizeConfig.screenWidth * 0.40,
                  child: Text(
                    "Welcome",
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
                                    "Log In",
                                    style: normalTextWhite,
                                  ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                await loginModel
                                    .signInUsingEmailIdAndPassword(
                                        _email, _password)
                                    .then((value) => {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(builder: (_) {
                                            return HomePage();
                                          }))
                                        })
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
                              "Don't have an account? ",
                              style: textFieldSize,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) {
                                  return SignUpPage();
                                }));
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 1,
                              width: SizeConfig.screenWidth * 0.35,
                              color: Colors.grey,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  shape: BoxShape.circle),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Text("Or"),
                              ),
                            ),
                            Container(
                              height: 1,
                              width: SizeConfig.screenWidth * 0.35,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: SizeConfig.screenWidth * 0.8,
                          height: SizeConfig.screenHeight * 0.06,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                await loginModel
                                    .googleSignIn()
                                    .then((user) async => {
                                          if (user != null)
                                            {
                                              await loginModel.createUserProfile(),
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (_) {
                                                return HomePage();
                                              }))
                                            }
                                          else
                                            {}
                                        })
                                    .catchError((e) => {print(e)});
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth * 0.16,
                                    height: SizeConfig.screenHeight * 0.09,
                                    child: Image.asset(
                                      "assets/logos/google.png",
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Login with Google",
                                    style: TextStyle(
                                      fontFamily: "OpenSans",
                                    ),
                                  )
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
