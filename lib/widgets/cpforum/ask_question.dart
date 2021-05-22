import 'package:devloperstudio/size_configuration.dart';
import 'package:devloperstudio/theme.dart';
import 'package:devloperstudio/widgets/cpforum/forumModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AskQuestion extends StatefulWidget {
  @override
  _AskQuestionState createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  CpForumModel model = new CpForumModel();
  String title = '', description = '', code = "", tags = "";
  List<String> finalTags = [];
  bool isLoading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userName = "", userProfilePic, userId = '';
  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    userName = FirebaseAuth.instance.currentUser.displayName;
    userProfilePic = FirebaseAuth.instance.currentUser.photoURL;
    userId = FirebaseAuth.instance.currentUser.uid;
    if (userName == "" || userName == null) {
      userName = "Anonymous";
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

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
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16,
              left: 10,
              right: 10,
              bottom: 16,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Question Title",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "OpenSans"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 100,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          title = value;
                        });
                      },
                      validator: (title) {
                        if (title.isEmpty) {
                          return 'Please Enter a Question Title';
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
                          hintText: "Enter your Question.",
                          hintStyle: textFieldSize),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Question Description and Explanation",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "OpenSans"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 100,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          description = value;
                        });
                      },
                      validator: (description) {
                        if (description.length < 50) {
                          return 'Please explain your question in more than 50 words';
                        }
                        return null;
                      },
                      cursorHeight: 20,
                      minLines: 20,
                      maxLines: null,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText: "Explain your Problem",
                          hintStyle: textFieldSize),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Paste your code",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "OpenSans"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 100,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          code = value;
                        });
                      },
                      cursorHeight: 20,
                      minLines: 20,
                      maxLines: null,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          contentPadding: EdgeInsets.only(left: 10),
                          hintText: "Paste your code",
                          hintStyle: textFieldSize),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Tags",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: "OpenSans"),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Add up to 5 tags to describe what your question is about",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontFamily: "OpenSans"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 100,
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          tags = value;
                        });
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
                          hintText: "eg. C++, Python, Java",
                          hintStyle: textFieldSize),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: SizeConfig.safeBlockHorizontal * 100,
                    height: SizeConfig.safeBlockVertical * 6,
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
                              "Publish",
                              style: normalTextWhite,
                            ),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (_formKey.currentState.validate()) {
                          finalTags = tags.split(',');
                          await model.askQuestion(title, description, code,
                              userName, finalTags, userProfilePic, userId);
                          Navigator.of(context).pop();
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
