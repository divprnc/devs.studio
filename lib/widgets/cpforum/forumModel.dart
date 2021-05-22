import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class CpForumModel {
  Future<void> rateQuestion(int rating, String uid, String docId) async {
    CollectionReference rateDb =
        FirebaseFirestore.instance.collection('RateQuestion');
    CollectionReference updateForum =
        FirebaseFirestore.instance.collection('CodingForum');
    if (rating == 1) {
      await rateDb
          .doc(uid)
          .get()
          .then((value) async => {
                if (!value.exists)
                  {
                    await rateDb
                        .doc(uid)
                        .set({docId: 1})
                        .then((value) async => {
                              await updateForum
                                  .doc(docId)
                                  .update({"Useful": FieldValue.increment(1)})
                                  .then((value) => {})
                                  .catchError((onError) {}),
                              Fluttertoast.showToast(
                                  msg: "Marked as useful.",
                                  toastLength: Toast.LENGTH_LONG),
                            })
                        .catchError((onError) {
                          Fluttertoast.showToast(
                              msg: "Oops! Something went Wrong",
                              toastLength: Toast.LENGTH_LONG);
                        })
                  }
                else
                  {
                    await rateDb
                        .doc(uid)
                        .update({
                          docId: 1,
                        })
                        .then((value) => {
                              Fluttertoast.showToast(
                                  msg: "Marked useful.",
                                  toastLength: Toast.LENGTH_LONG),
                            })
                        .catchError((onError) {
                          Fluttertoast.showToast(
                              msg: "Oops! Something went Wrong",
                              toastLength: Toast.LENGTH_LONG);
                        })
                  }
              })
          .catchError((e) {});
    } else {
      if (rating == 0) {
        await rateDb
            .doc(uid)
            .get()
            .then((value) async => {
                  if (!value.exists)
                    {
                      await rateDb
                          .doc(uid)
                          .set({docId: 0})
                          .then((value) async => {
                                await updateForum
                                    .doc(docId)
                                    .update(
                                        {"Useful": FieldValue.increment(-1)})
                                    .then((value) => {})
                                    .catchError((onError) {}),
                                Fluttertoast.showToast(
                                    msg: "Marked as useful.",
                                    toastLength: Toast.LENGTH_LONG),
                              })
                          .catchError((onError) {
                            Fluttertoast.showToast(
                                msg: "Oops! Something went Wrong",
                                toastLength: Toast.LENGTH_LONG);
                          })
                    }
                  else
                    {
                      await rateDb
                          .doc(uid)
                          .update({
                            docId: 0,
                          })
                          .then((value) async => {
                                await updateForum
                                    .doc(docId)
                                    .update(
                                        {"Useful": FieldValue.increment(-1)})
                                    .then((value) => {})
                                    .catchError((onError) {}),
                                Fluttertoast.showToast(
                                    msg: "Marked as not useful.",
                                    toastLength: Toast.LENGTH_LONG),
                              })
                          .catchError((onError) {
                            Fluttertoast.showToast(
                                msg: "Oops! Something went Wrong",
                                toastLength: Toast.LENGTH_LONG);
                          })
                    }
                })
            .catchError((e) {});
      }
    }
  }

  Future<void> askQuestion(
      String title,
      String content,
      String code,
      String name,
      List<String> tag,
      String profileLink,
      String userWhoAskedId) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid;
    CollectionReference db =
        FirebaseFirestore.instance.collection('CodingForum');
    String date = DateFormat("dd-MM-yyyy HH:mm").format(DateTime.now());
    CollectionReference userdb =
        FirebaseFirestore.instance.collection('UserProfile');
    Map<String, dynamic> forumData = {
      "Title": title,
      "Description": content,
      "Code": code,
      "Tags": tag,
      "Date": date,
      "AskedBy": name,
      "ProfilePicLink": profileLink,
      "Replies": [],
      "Useful": 0,
      "AskedById": userWhoAskedId,
    };
    await db
        .add(forumData)
        .then((value) => {
              //aDD CODE FOR UPDATE THE TOTAL POSTS IN PROFILE
              userdb
                  .doc(uid)
                  .update({"TotalPosts": FieldValue.increment(1)})
                  .then((value) => {})
                  .catchError((onError) {}),
              Fluttertoast.showToast(
                  msg: "Question Published", toastLength: Toast.LENGTH_LONG),
              print("Question Asked")
            })
        .catchError((error) => {
              Fluttertoast.showToast(
                  msg: "Failed to post question!!",
                  toastLength: Toast.LENGTH_LONG),
              print("Failed to ask question: $error")
            });
  }

  Future<void> sendNotification(
      String questionTitle,
      String questionId,
      String repliedByName,
      String repliedById,
      String askedById,
      String repliedByProfilePic) async {
    CollectionReference db =
        FirebaseFirestore.instance.collection('Notifications');
    String date = DateFormat("dd-MM-yyyy HH:mm").format(DateTime.now());
    Map<String, dynamic> notification = {
      "QuestionTitle": questionTitle,
      "QuestionId": questionId,
      "RepliedById": repliedById,
      "RepliedByName": repliedByName,
      "RepliedByPic": repliedByProfilePic,
      "AskedById": askedById,
      "DateAndTime": date,
    };
    if (repliedById != askedById) {
      await db.doc(askedById).get().then((val) async {
        if (!val.exists) {
          await db.doc(askedById).set({
            "Notification": [notification]
          }).then((value) async {});
        } else {
          await db.doc(askedById).update({
            "Notification": FieldValue.arrayUnion([notification])
          }).then((value) => {});
        }
      });
    }
  }

  Future<void> replyAnswer(String content, String code, String name,
      String profileLink, String docId) async {
    CollectionReference db =
        FirebaseFirestore.instance.collection('CodingForum');
    String date = DateFormat("dd-MM-yyyy HH:mm").format(DateTime.now());
    Map<String, dynamic> anserData = {
      "Code": code,
      "Explanation": content,
      "RepliedBy": name,
      "ProfileLink": profileLink,
      "Date": date,
      "Useful": 0,
    };
    await db
        .doc(docId)
        .update({
          "Replies": FieldValue.arrayUnion([anserData])
        })
        .then((value) => {
              Fluttertoast.showToast(
                  msg: "Answer Published", toastLength: Toast.LENGTH_LONG)
            })
        .catchError((error) {
          Fluttertoast.showToast(
              msg: "Failed to reply answer!!", toastLength: Toast.LENGTH_LONG);
        });
  }
}
