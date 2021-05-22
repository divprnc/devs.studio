import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class QuizModel {
  Future<void> participateInQuiz(
      String userId,
      String userProfilePic,
      String userName,
      String quizId,
      int amount,
      int walletAmount,
      List quizQuestions) async {
    CollectionReference updateTransactions =
        FirebaseFirestore.instance.collection('UserTransactions');
    CollectionReference updateProfile =
        FirebaseFirestore.instance.collection('UserProfile');
    CollectionReference updateQuiz =
        FirebaseFirestore.instance.collection('LiveQuizes');
    String date = DateFormat("dd-MM-yyyy HH:mm").format(DateTime.now());
    Map<String, dynamic> transactions = {
      "Amount": amount,
      "DateAndTime": date,
      "QuizId": quizId,
      "Transfer": "OUT",
      "Type": "Quiz Joined",
    };
    Map<String, dynamic> participantsDetails = {
      "UserId": userId,
      "UserName": userName,
      "UserProfilePic": userProfilePic,
      "DateAndTime": date,
    };
    await updateTransactions
        .doc(userId)
        .update({
          "WalletAmount": walletAmount,
          "Transactions": FieldValue.arrayUnion([transactions])
        })
        .then((value) async => {})
        .catchError((e) {
          print(e);
        });
    await updateQuiz
        .doc(quizId)
        .update({
          "Participants": FieldValue.arrayUnion([participantsDetails]),
        })
        .then((value) async => {})
        .catchError((e) {
          print(e);
        });
    await updateProfile
        .doc(userId)
        .update({"WalletAmount": walletAmount})
        .then((value) => {
              Fluttertoast.showToast(
                  msg: "Quiz Started", toastLength: Toast.LENGTH_LONG)
            })
        .catchError((onError) {});
  }

  Future<void> updateProfileAfterQuizAndTransaction(
      String userId,
      String userProfilePic,
      String userName,
      String quizId,
      int marks,
      List questionTimings,
      String quizName) async {
    String date = DateFormat("dd-MM-yyyy HH:mm").format(DateTime.now());
    CollectionReference mycontest =
        FirebaseFirestore.instance.collection('UserProfile');
    Map<String, dynamic> participantsDetail = {
      "UserId": userId,
      "UserName": userName,
      "UserProfilePic": userProfilePic,
      "DateAndTime": date,
      "TotalMarks": marks,
      "QuestionTimings": questionTimings,
      "QuizId": quizId,
      "QuizName": quizName,
    };
    print(participantsDetail);
    mycontest
        .doc(userId)
        .update({
          "Participated": FieldValue.arrayUnion([participantsDetail])
        })
        .then((value) async => {
              Fluttertoast.showToast(
                  msg: "Quiz is over, results will be displayed in my contest",
                  toastLength: Toast.LENGTH_LONG)
            })
        .catchError((onError) {
          Fluttertoast.showToast(
              msg: "Oops! Something went Wrong",
              toastLength: Toast.LENGTH_LONG);
        });
  }
}
