import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lagbaja_cleaning/models/pricing.dart';
import 'package:lagbaja_cleaning/models/sessions.dart';
import 'package:lagbaja_cleaning/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
  //user info section
  final CollectionReference userInfoCollection =
      FirebaseFirestore.instance.collection('userInfo');

  Future updateUserInfo(
      {String firstName,
      String lastName,
      String address,
      String state,
      String city,
      String phoneNumber}) async {
    return await userInfoCollection.doc(uid).set({
      "firstName": firstName,
      "lastName": lastName,
      "address": address,
      "state": state,
      "city": city,
      "phoneNumber": phoneNumber
    });
  }

  UserProfileInfo _userInfoFromDocumentSnapshot(snapshot) {
    return snapshot.data == null
        ? null
        : UserProfileInfo(
            uid: uid,
            firstName: snapshot.data()["firstName"],
            lastName: snapshot.data()["lastName"],
            state: snapshot.data()["state"],
            phoneNumber: snapshot.data()["phoneNumber"],
            address: snapshot.data()["address"],
            city: snapshot.data()["city"],
          );
  }

  Stream<UserProfileInfo> get getUserInfo {
    return userInfoCollection
        .doc(uid)
        .snapshots()
        .map(_userInfoFromDocumentSnapshot);
  }

  // secret keys section
  final CollectionReference secretKeyCollection =
      FirebaseFirestore.instance.collection('secretKeys');

  SecretKey _getSecretKeyFromDb(snapshot) {
    return SecretKey(snapshot.data()["key"]);
  }

  Stream<SecretKey> get getPaystackSecretKey {
    return secretKeyCollection
        .doc('paystack-key')
        .snapshots()
        .map(_getSecretKeyFromDb);
  }

  //cleaning sessions section
  final CollectionReference cleaningSessionCollection =
      FirebaseFirestore.instance.collection('cleaningSession');

  //create and update cleaning session
  Future updateCleaningSession(
      {String location,
      String apartmentType,
      String subscription,
      double totalCost,
      int rating = 0,
      bool isRated,
      bool isPaid,
      String cleaningDay,
      bool isCompleted,
      DateTime dateOrdered,
      DateTime cleaningDate,
      int routineLength = 0,
      int routineProgress = 0,
      String userUid}) async {
    Map<String, dynamic> data = {
      "location": location,
      "apartmentType": apartmentType,
      "subscription": subscription,
      "totalCost": totalCost,
      "rating": rating,
      "isRated": isRated,
      "routineLength": routineLength,
      "routineProgress": routineProgress,
      "isCompleted": isCompleted,
      "isPaid": isPaid,
      "cleaningDay": cleaningDay,
      "userUid": userUid,
      "dateOrdered": dateOrdered,
      "cleaningDate": cleaningDate
    };
    try {
      void added = await cleaningSessionCollection.doc().set(data);
      return null;
    } catch (e) {
      return null;
    }
  }

  CleaningSession _cleaningSessionFromDocumentSnapshot(snapshot) {
    return snapshot.data == null
        ? null
        : CleaningSession(
            uid: snapshot.data()["uid"],
            userUid: snapshot.data()["userUid"],
            location: snapshot.data()["location"],
            apartmentType: snapshot.data()["apartmentType"],
            orderDate: snapshot.data()["dateOrdered"].toDate(),
            cleaningDate: snapshot.data()["cleaningDate"].toDate(),
            subscription: snapshot.data()["subscription"],
            routineLength: snapshot.data()["routineLength"],
            routineProgress: snapshot.data()["routineProgress"],
            cleaningDay: snapshot.data()["cleaningDay"],
            totalCost: snapshot.data()["totalCost"],
            rating: snapshot.data()["rating"],
            isRated: snapshot.data()["isRated"],
            isPaid: snapshot.data()["isPaid"],
            isCompleted: snapshot.data()["isCompleted"]);
  }

  List<CleaningSession> _cleaningSessionListFromQuerySnapshot(
      QuerySnapshot query) {
    return query.docs.map(_cleaningSessionFromDocumentSnapshot).toList();
  }

  Stream<List<CleaningSession>> get allUserCleaningSession {
    return cleaningSessionCollection
        .where("userUid", isEqualTo: uid)
        .orderBy("dateOrdered", descending: true)
        .snapshots()
        .map(_cleaningSessionListFromQuerySnapshot);
  }

  Stream<QuerySnapshot> get allStreamUserCleaningSession {
    return cleaningSessionCollection
        .where("userUid", isEqualTo: uid)
        .orderBy("dateOrdered", descending: true)
        .snapshots();
  }

  CompletedSessionOverview _completedStringFromStreamInt(int streamInteger) {
    return CompletedSessionOverview(completed: streamInteger.toString());
  }

  PendingSessionOverview _pendingStringFromStreamInt(int streamInteger) {
    return PendingSessionOverview(pending: streamInteger.toString());
  }

  TotalSessionOverview _totalStringFromStreamInt(int streamInteger) {
    return TotalSessionOverview(total: streamInteger.toString());
  }

  Future<SessionOverview> get completedCleaningSessionOverView async {
    QuerySnapshot completedResult = await cleaningSessionCollection
        .where("userUid", isEqualTo: uid)
        .where("isCompleted", isEqualTo: true)
        .get();
    int completedDocs = completedResult.docs.length;

    QuerySnapshot pendingResult = await cleaningSessionCollection
        .where("userUid", isEqualTo: uid)
        .where("isCompleted", isEqualTo: false)
        .get();
    int pendingDocs = pendingResult.docs.length;

    QuerySnapshot totalResult =
        await cleaningSessionCollection.where("userUid", isEqualTo: uid).get();
    int totalDocs = totalResult.docs.length;

    return SessionOverview(
        completed: completedDocs.toString(),
        pending: pendingDocs.toString(),
        total: totalDocs.toString());
  }

  Stream<PendingSessionOverview> get pendingCleaningSessionOverView {
    return cleaningSessionCollection
        .where("userUid", isEqualTo: uid)
        .snapshots()
        .length
        .asStream()
        .map(_pendingStringFromStreamInt);
  }

  Stream<TotalSessionOverview> get totalCleaningSessionOverView {
    return cleaningSessionCollection
        .where("userUid", isEqualTo: uid)
        .snapshots()
        .length
        .asStream()
        .map(_totalStringFromStreamInt);
  }
}
