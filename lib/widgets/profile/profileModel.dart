import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileModel {
  void updateAccountDetails(
      String upiId, String accno, String ifsc, String name, String uid) async {
    CollectionReference updateForum =
        FirebaseFirestore.instance.collection('UserProfile');
    await updateForum
        .doc(uid)
        .update({
          "AccoundData": {
            "AccountNumber": accno,
            "AccountOwnerName": name,
            "IFSC": ifsc,
            "UpiId": upiId
          }
        })
        .then((value) => {
              Fluttertoast.showToast(
                  msg: "Account Details Updated",
                  toastLength: Toast.LENGTH_LONG)
            })
        .catchError((onError) {});
  }
}
