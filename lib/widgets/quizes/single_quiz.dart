import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:devloperstudio/theme.dart';
import 'package:devloperstudio/widgets/mainpage/homepage.dart';
import 'package:devloperstudio/widgets/quizes/quizModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

import '../../size_configuration.dart';

class SingleQuiz extends StatefulWidget {
  final List questions;
  final String quizId;
  SingleQuiz(this.questions, this.quizId);
  @override
  _SingleQuizState createState() => _SingleQuizState();
}

class _SingleQuizState extends State<SingleQuiz> {
  QuizModel quizModel = new QuizModel();
  bool isLoading = false;
  String userEmail, userId, userProfilePic, userName;
  List questionTimings = [];
  int quesIndex = 1;
  int timer = 35;
  String showtiming = "00";
  bool cancelTimer = false;
  int marks = 0;
  List quizQuestions;
  var item = List<bool>.generate(50, (i) => false);
  Color colorToShow = Colors.black;
  Color colorWhenTick = Colors.blue;
  Map<String, Color> btnColor = {
    "a": Colors.black,
    "b": Colors.black,
    "c": Colors.black,
    "d": Colors.black
  };
  bool changeColor = false;
  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });
    userEmail = FirebaseAuth.instance.currentUser.email;
    userId = FirebaseAuth.instance.currentUser.uid;
    userProfilePic = FirebaseAuth.instance.currentUser.photoURL;
    userName = FirebaseAuth.instance.currentUser.displayName;
    if (userName == "" || userName == null) {
      userName = "Devs.Studio";
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    startTimer();
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    quizQuestions = widget.questions;
    Widget codinghilighter(BuildContext context, String finalCode) {
      return Container(
        width: SizeConfig.safeBlockHorizontal * 95,
        height: SizeConfig.safeBlockVertical * 40,
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.blue,
          width: 2,
        )),
        child: SyntaxView(
            code: finalCode,
            syntax: Syntax.C,
            syntaxTheme: SyntaxTheme.dracula(),
            withZoom: true,
            withLinesCount: true),
      );
    }

    Widget choiceButton(BuildContext context, String optionKey) {
      return Padding(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        child: GestureDetector(
          //   onTapDown: (details) {
          //     setState(() {
          //       changeColor = true;
          //     });
          //   },
          //   onTapUp: (details) {
          //     setState(() {
          //       changeColor = false;
          //     });
          //   },
          onTap: () {
            setState(() {
              checkAnswer(optionKey);
            });
          },
          child: Container(
            constraints:
                BoxConstraints(minHeight: 50, minWidth: double.infinity),
            decoration: BoxDecoration(
                border: Border.all(
              color: btnColor[optionKey],
            )),
            child: Row(
              children: [
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child:
                        Text(quizQuestions[2][quesIndex.toString()][optionKey]))
              ],
            ),
          ),
        ),
      );
    }

    Future<bool> _backButtonPressed() {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                elevation: 10,
                backgroundColor: Colors.white,
                title: Text(
                  quizQuestions[0]["QuizName"],
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "OpenSans",
                  ),
                ),
                content: Text("You can't go back at this stage."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: Text(
                        "Okay",
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ],
              ));
    }

    SizeConfig().init(context);
    return WillPopScope(
      onWillPop: _backButtonPressed,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: SizeConfig.safeBlockVertical * 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        quizQuestions[0]["QuizName"],
                        style: normalText,
                      ),
                      Text(showtiming,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontFamily: "OpenSans")),
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.safeBlockVertical * 2,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  width: SizeConfig.screenWidth,
                  child: new Column(
                    children: <Widget>[
                      Text(
                        quizQuestions[1][quesIndex.toString()]["ques"],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: "OpenSans"),
                      ),
                    ],
                  ),
                ),
                quizQuestions[1][quesIndex.toString()]["code"] == null ||
                        quizQuestions[1][quesIndex.toString()]["code"] == ""
                    ? Container()
                    : codinghilighter(
                        context,
                        quizQuestions[1][quesIndex.toString()]["code"]
                            .toString()),
                Column(
                  children: [
                    choiceButton(context, "a"),
                    choiceButton(context, "b"),
                    choiceButton(context, "c"),
                    choiceButton(context, "d"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkAnswer(String optionKey) {
    // print(quizQuestions[3][quesIndex.toString()] +
    //     quizQuestions[2][quesIndex.toString()][optionKey]);
    if (quizQuestions[3][quesIndex.toString()] ==
        quizQuestions[2][quesIndex.toString()][optionKey]) {
      marks = marks + 10;
      print(" MArks: " + marks.toString());
    } else {}
    setState(() {
      btnColor[optionKey] = Colors.blue;
      cancelTimer = true;
    });
    Timer(Duration(seconds: 1), nextQuestion);
  }

  void nextQuestion() async {
    cancelTimer = false;
    int questionTime = widget.questions[0]["QuizPerQuestionTime"] - timer;
    print("$quesIndex -> $questionTime");
    questionTimings.add(questionTime);
    timer = widget.questions[0]["QuizPerQuestionTime"];
    setState(() {
      if (quesIndex < quizQuestions[1].length) {
        quesIndex++;
      } else {
        // QuizModel quizModel = new QuizModel();
        quizModel.updateProfileAfterQuizAndTransaction(
            userId,
            userProfilePic,
            userName,
            widget.quizId,
            marks,
            questionTimings,
            widget.questions[0]["QuizName"]);
        // print(questionTimings);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return HomePage();
        }));
        // Fluttertoast.showToast(
        //     msg: "Quiz is over, results will be displayed in my contest",
        //     toastLength: Toast.LENGTH_LONG);
      }
      btnColor["a"] = Colors.black;
      btnColor["b"] = Colors.black;
      btnColor["c"] = Colors.black;
      btnColor["d"] = Colors.black;
    });
    startTimer();
  }

  void startTimer() async {
    const second = Duration(seconds: 1);
    Timer.periodic(second, (Timer t) {
      if (mounted) {
        setState(() {
          if (timer < 1) {
            t.cancel();
            nextQuestion();
          } else if (cancelTimer == true) {
            t.cancel();
          } else {
            timer = timer - 1;
          }
          showtiming = timer.toString();
        });
      }
    });
  }
}
