import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devloperstudio/theme.dart';
import 'package:devloperstudio/widgets/quizes/quizModel.dart';
import 'package:devloperstudio/widgets/quizes/single_quiz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../size_configuration.dart';

class QuizDetails extends StatefulWidget {
  @override
  _QuizDetailsState createState() => _QuizDetailsState();
}

class _QuizDetailsState extends State<QuizDetails> {
  QuizModel quizModel = new QuizModel();
  bool isLoading = false;
  bool participatingLoader = false;
  String userEmail, userId, userProfilePic, userName;
  int walletAmount, quizAmount;
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
    FirebaseFirestore.instance
        .collection('UserTransactions')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        walletAmount = documentSnapshot.get('WalletAmount');
      }
    });
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
    String quizId = routeArguments['quizId'];
    Stream documentStream = FirebaseFirestore.instance
        .collection('LiveQuizes')
        .doc(quizId)
        .snapshots();
    Widget confirmationDialog(
        BuildContext context, int quizAmount, List quizQuestions, int timings) {
      // print(quizData);
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 40,
        child: Container(
          width: SizeConfig.safeBlockHorizontal * 100,
          height: SizeConfig.safeBlockVertical * 45,
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                width: SizeConfig.safeBlockHorizontal * 100,
                height: SizeConfig.safeBlockVertical * 8,
                child: Center(
                  child: Text(
                    "Contest Joining Confirmation",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "OpenSans"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Available Balance",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "OpenSans",
                      ),
                    ),
                    Text(
                      "₹ " + walletAmount.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.blue,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Contest Price",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: "OpenSans",
                      ),
                    ),
                    Text(
                      "₹ " + quizAmount.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "OpenSans",
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.blue,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text("Join the contest by reading our "),
                    Text("Terms & Conditions",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.blue),
                ),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  if (walletAmount < quizAmount) {
                    Fluttertoast.showToast(
                        msg: "Insufficient Amount!!",
                        toastLength: Toast.LENGTH_LONG);
                  } else {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SingleQuiz(quizQuestions, quizId),
                        ));
                    await quizModel
                        .participateInQuiz(
                            userId,
                            userProfilePic,
                            userName,
                            quizId,
                            quizAmount,
                            walletAmount - quizAmount,
                            quizQuestions)
                        .whenComplete(() => {});
                  }
                  setState(() {
                    isLoading = false;
                  });
                },
                child: Text("Confirm and Play",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: "OpenSans")),
              ),
            ],
          ),
        ),
      );
    }

    Widget winningDialog(
        BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      print(snapshot.data.get("Winners")["4"]);
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 40,
        backgroundColor: Colors.white,
        child: Container(
          width: SizeConfig.safeBlockHorizontal * 90,
          height: SizeConfig.safeBlockVertical * 40,
          child: Column(
            children: [
              Container(
                color: Colors.blue,
                width: SizeConfig.safeBlockHorizontal * 100,
                height: SizeConfig.safeBlockVertical * 8,
                child: Center(
                  child: Text(
                    "Winners Prizes",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "OpenSans"),
                  ),
                ),
              ),
              snapshot.data.get("Winners")["1"] == null ||
                      snapshot.data.get("Winners")["1"] == ""
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Rank 1",
                          style: dashboard,
                        ),
                        Text(
                          "₹ " + snapshot.data.get("Winners")["1"].toString(),
                          style: dashboard,
                        ),
                      ],
                    ),
              snapshot.data.get("Winners")["4"] == null ||
                      snapshot.data.get("Winners")["4"] == ""
                  ? Container()
                  : Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
              snapshot.data.get("Winners")["2"] == null ||
                      snapshot.data.get("Winners")["2"] == ""
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Rank 2",
                          style: dashboard,
                        ),
                        Text(
                          "₹ " + snapshot.data.get("Winners")["2"].toString(),
                          style: dashboard,
                        ),
                      ],
                    ),
              snapshot.data.get("Winners")["2"] == null ||
                      snapshot.data.get("Winners")["2"] == ""
                  ? Container()
                  : Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
              snapshot.data.get("Winners")["3"] == null ||
                      snapshot.data.get("Winners")["3"] == ""
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Rank 3",
                          style: dashboard,
                        ),
                        Text(
                          "₹ " + snapshot.data.get("Winners")["3"].toString(),
                          style: dashboard,
                        ),
                      ],
                    ),
              snapshot.data.get("Winners")["3"] == null ||
                      snapshot.data.get("Winners")["3"] == ""
                  ? Container()
                  : Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
              snapshot.data.get("Winners")["4"] == null ||
                      snapshot.data.get("Winners")["4"] == ""
                  ? Container()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Rank 4-10",
                          style: dashboard,
                        ),
                        Text(
                          "₹ " + snapshot.data.get("Winners")["4"].toString(),
                          style: dashboard,
                        ),
                      ],
                    ),
              snapshot.data.get("Winners")["4"] == null ||
                      snapshot.data.get("Winners")["4"] == ""
                  ? Container()
                  : Divider(
                      color: Colors.grey,
                      height: 2,
                    ),
              // SizedBox(
              //   height: 10,
              // ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: "OpenSans")),
              ),
            ],
          ),
        ),
      );
    }

    SizeConfig().init(context);
    // print(userEmail + " " + userId);
    return Scaffold(
      body: isLoading
          ? Center(
              child: SpinKitRing(
                color: Colors.blue,
                lineWidth: 4,
                size: 40,
              ),
            )
          : StreamBuilder<DocumentSnapshot>(
              stream: documentStream,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  Fluttertoast.showToast(
                      msg: "Something went wrong",
                      toastLength: Toast.LENGTH_LONG);
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitRing(
                      color: Colors.blue,
                      lineWidth: 4,
                      size: 40,
                    ),
                  );
                }
                quizAmount = snapshot.data.get('Price');
                return Container(
                  child: Column(
                    children: [
                      Container(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight,
                        child: Stack(
                          children: [
                            Positioned(
                              top: SizeConfig.screenHeight * 0.1,
                              left: SizeConfig.screenWidth * 0.1,
                              child: Text(
                                snapshot.data.get('Name'),
                                style: quizD,
                              ),
                            ),
                            Positioned(
                              top: SizeConfig.screenHeight * 0.15,
                              left: SizeConfig.screenWidth * 0.1,
                              child: Text(
                                "Play Before " +
                                    snapshot.data.get('Date') +
                                    " " +
                                    snapshot.data.get('Time'),
                                style: profileTextWhite,
                              ),
                            ),
                            // Positioned(
                            //   top: SizeConfig.screenHeight * 0.18,
                            //   left: SizeConfig.screenWidth * 0.1,
                            //   child: Text(
                            //     snapshot.data.data()['Time'],
                            //     style: profileTextWhite,
                            //   ),
                            // ),
                            Positioned(
                              top: SizeConfig.screenHeight * 0.21,
                              left: SizeConfig.screenWidth * 0.1,
                              child: Text(
                                '₹ ' + snapshot.data.get('Price').toString(),
                                style: quizD,
                              ),
                            ),
                            Positioned(
                              top: SizeConfig.screenHeight * 0.3,
                              left: SizeConfig.screenWidth * 0.1,
                              child: Text(
                                snapshot.data
                                    .get('questionsDetails')[1]
                                    .length
                                    .toString(),
                                style: quizD,
                              ),
                            ),
                            Positioned(
                              top: SizeConfig.screenHeight * 0.35,
                              left: SizeConfig.screenWidth * 0.1,
                              child: Text(
                                'Per Question ' +
                                    snapshot.data
                                        .get('questionsDetails')[0]
                                            ['QuizPerQuestionTime']
                                        .toString() +
                                    ' Second',
                                style: profileTextWhite,
                              ),
                            ),
                            Positioned(
                              top: SizeConfig.screenHeight * 0.45,
                              left: SizeConfig.screenWidth * 0.1,
                              child: Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return winningDialog(
                                                context, snapshot);
                                          });
                                    },
                                    child: Text(
                                      'Check Winnings',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: "OpenSans",
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 50,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return winningDialog(
                                                context, snapshot);
                                          });
                                    },
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: SizeConfig.screenHeight * 0.94,
                              left: SizeConfig.screenWidth * 0.1,
                              child: Container(
                                width: SizeConfig.screenWidth * 0.8,
                                height: SizeConfig.screenHeight * 0.039,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // print(snapshot.data.data()["quizData"]);
                                          return confirmationDialog(
                                              context,
                                              quizAmount,
                                              snapshot.data
                                                  .get("questionsDetails"),
                                              snapshot.data.get(
                                                      "questionsDetails")[0]
                                                  ["QuizPerQuestionTime"]);
                                        });
                                  },
                                  child: Text("Join Contest",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: "OpenSans")),
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: new BoxDecoration(
                          color: Colors.blue,
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            colorFilter: new ColorFilter.mode(
                                Colors.black.withOpacity(0.2),
                                BlendMode.dstATop),
                            image: new AssetImage(
                              'assets/images/quiz_dt.jpg',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
