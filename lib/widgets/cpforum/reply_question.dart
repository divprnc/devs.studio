import 'package:devloperstudio/size_configuration.dart';
import 'package:devloperstudio/theme.dart';
import 'package:devloperstudio/widgets/cpforum/forumModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ReplyQuestion extends StatefulWidget {
  @override
  _ReplyQuestionState createState() => _ReplyQuestionState();
}

class _ReplyQuestionState extends State<ReplyQuestion> {
  CpForumModel model = new CpForumModel();
  String explanation = '', eCode = '';
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
    final routeArguments =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    String questionId = routeArguments['questionId'];
    String questionTitle = routeArguments['questionTitle'];
    String askedById = routeArguments['askedBy'];
    print(askedById + " " + questionTitle + " " + questionId);
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
                    "Explain Your Solution",
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
                          explanation = value;
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
                          hintText: "Explain Your Solution",
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
                          eCode = value;
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
                              "Post Your Answer",
                              style: normalTextWhite,
                            ),
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        if (_formKey.currentState.validate()) {
                          model
                              .replyAnswer(explanation, eCode, userName,
                                  userProfilePic, questionId)
                              .whenComplete(() => {
                                    model.sendNotification(
                                        questionTitle,
                                        questionId,
                                        userName,
                                        userId,
                                        askedById,
                                        userProfilePic)
                                  });
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
