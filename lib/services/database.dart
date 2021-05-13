import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
  final CollectionReference userInfoCollection =
      Firestore.instance.collection('userInfo');

  Future updateUserInfo(
      {String firstName,
      String lastName,
      String address,
      String state,
      String phoneNUmber}) async {
    return await userInfoCollection.document(uid).setData({
      "firstName": firstName,
      "lastName": lastName,
      "address": address,
      "state": state,
      "phoneNumber": phoneNUmber
    });
  }

  Stream<DocumentSnapshot> get userInfo {
    return userInfoCollection.document(uid).snapshots();
  }
}
