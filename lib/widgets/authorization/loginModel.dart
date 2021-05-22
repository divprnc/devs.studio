import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginModel {
  Future<void> createUserProfile() async {
    User user = FirebaseAuth.instance.currentUser;
    String uid = user.uid;
    CollectionReference db =
        FirebaseFirestore.instance.collection('UserProfile');
    CollectionReference adb =
        FirebaseFirestore.instance.collection('UserTransactions');
    CollectionReference ndb =
        FirebaseFirestore.instance.collection('Notifications');
    Map<String, dynamic> data = {
      "UID": user.uid.toString(),
      "Email": user.email.toString(),
      "FullName": user.displayName.toString(),
      "WalletAmount": 0,
      "TotalPosts": [],
      "AccountData": {
        "AccountNumber": "",
        "AccountOwnerName": "",
        "IFSC": "",
        "UpiId": "",
      },
      "Participated": [],
      "QuizWon": 0,
    };
    Map<String, dynamic> accountData = {
      "WalletAmount": 0,
      "UID": uid,
      "Transactions": [],
    };
    await FirebaseFirestore.instance
        .collection("UserProfile")
        .doc(uid)
        .get()
        .then((user) async => {
              if (!user.exists)
                {
                  await db
                      .doc(uid)
                      .set(data)
                      .then((value) => print("User Added"))
                      .catchError(
                          (error) => print("Failed to add user: $error")),
                  await adb
                      .doc(uid)
                      .set(accountData)
                      .then((value) => print("Transactions Addded"))
                      .catchError((error) =>
                          print("Failde toadd transactions : $error")),
                  await ndb.doc(uid).set({
                    "Notification": [],
                    "NewCount": 0,
                    "OldCount": 0,
                  }).then((value) async {})
                }
            });
  }

  Future<User> googleSignIn() async {
    User user;
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      user = FirebaseAuth.instance.currentUser;
    } catch (e) {
      print(e);
    }
    if (user != null) {
      return user;
    } else {
      return null;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> checkUser() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        print("User Found");
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<void> signupUsingEmailIdAndPassword(
      String emailId, String password) async {
    try {
      print("Started...");
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emailId, password: password);
      User user = FirebaseAuth.instance.currentUser;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
        Fluttertoast.showToast(
          msg: "Please verify your email and login again",
          toastLength: Toast.LENGTH_LONG,
        );
      }
      print("Done");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
          msg: "The password is too weak.",
          toastLength: Toast.LENGTH_LONG,
        );
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: "Email already in use.",
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInUsingEmailIdAndPassword(
      String emailId, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailId, password: password);
      User user = FirebaseAuth.instance.currentUser;

      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: "Oops! User not Found",
          toastLength: Toast.LENGTH_LONG,
        );
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(
          msg: "Wrong Password! Please try again",
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }
  }
}
