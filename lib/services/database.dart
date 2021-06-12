import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lagbaja_cleaning/models/sessions.dart';
import 'package:lagbaja_cleaning/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});
  //user info section
  final CollectionReference userInfoCollection =
      Firestore.instance.collection('userInfo');

  Future updateUserInfo(
      {String firstName,
      String lastName,
      String address,
      String state,
      String city,
      String phoneNumber}) async {
    return await userInfoCollection.document(uid).setData({
      "firstName": firstName,
      "lastName": lastName,
      "address": address,
      "state": state,
      "city": city,
      "phoneNumber": phoneNumber
    });
  }

  UserProfileInfo _userInfoFromDocumentSnapshot(DocumentSnapshot snapshot) {
    return snapshot.data == null
        ? null
        : UserProfileInfo(
            uid: uid,
            firstName: snapshot.data["firstName"],
            lastName: snapshot.data["lastName"],
            state: snapshot.data["state"],
            phoneNumber: snapshot.data["phoneNumber"],
            address: snapshot.data["address"],
            city: snapshot.data["city"],
          );
  }

  Stream<UserProfileInfo> get getUserInfo {
    return userInfoCollection
        .document(uid)
        .snapshots()
        .map(_userInfoFromDocumentSnapshot);
  }

  //cleaning sessions section
  final CollectionReference cleaningSessionCollection =
      Firestore.instance.collection('cleaningSession');

  //create and update cleaning session
  Future updateCleaningSession(
      {String location,
      String apartmentType,
      String subscription,
      double totalCost,
      int rating,
      bool isRated,
      bool isPaid,
      bool isCompleted,
      DateTime dateOrdered,
      DateTime cleaningDate,
      String userUid}) async {
    Map<String, dynamic> data = {
      "location": location,
      "apartmentType": apartmentType,
      "subscription": subscription,
      "totalCost": totalCost,
      "rating": rating,
      "isRated": isRated,
      "isCompleted": isCompleted,
      "isPaid": isPaid,
      "userUid": userUid,
      "dateOrdered": dateOrdered,
      "cleaningDate": cleaningDate
    };
    return await cleaningSessionCollection.document().setData(data);
  }

  CleaningSession _cleaningSessionFromDocumentSnapshot(
      DocumentSnapshot snapshot) {
    return snapshot.data == null
        ? null
        : CleaningSession(
            uid: snapshot.data["uid"],
            userUid: snapshot.data["userUid"],
            location: snapshot.data["location"],
            apartmentType: snapshot.data["apartmentType"],
            subscription: snapshot.data["subscription"],
            totalCost: snapshot.data["totalCost"],
            rating: snapshot.data["rating"],
            isRated: snapshot.data["isRated"],
            isPaid: snapshot.data["isPaid"],
            isCompleted: snapshot.data["isCompleted"]);
  }

  List<CleaningSession> _cleaningSessionListFromQuerySnapshot(
      QuerySnapshot query) {
    List<CleaningSession> cleaningList = [];
    query.documents.forEach((snapshot) {
      cleaningList.add(CleaningSession(
          uid: snapshot.data["uid"],
          userUid: snapshot.data["userUid"],
          location: snapshot.data["location"],
          apartmentType: snapshot.data["apartmentType"],
          subscription: snapshot.data["subscription"],
          totalCost: snapshot.data["totalCost"],
          rating: snapshot.data["rating"],
          isRated: snapshot.data["isRated"],
          isPaid: snapshot.data["isPaid"],
          isCompleted: snapshot.data["isCompleted"]));
    });
    return cleaningList;
  }

  Stream<List<CleaningSession>> get allUserCleaningSession {
    return cleaningSessionCollection
        .where("userUid", isEqualTo: uid)
        .orderBy("dateOrdered", descending: true)
        .snapshots()
        .map(_cleaningSessionListFromQuerySnapshot);
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
    print("hereeeeeeeeeeeeeeeee");
    dynamic completedResult = await cleaningSessionCollection
        .where("userUid", isEqualTo: uid)
        .where("isCompleted", isEqualTo: true)
        .getDocuments();
    dynamic completedDocs = completedResult.documents.length;

    dynamic pendingResult = await cleaningSessionCollection
        .where("userUid", isEqualTo: uid)
        .where("isCompleted", isEqualTo: false)
        .getDocuments();
    dynamic pendingDocs = pendingResult.documents.length;

    dynamic totalResult = await cleaningSessionCollection
        .where("userUid", isEqualTo: uid)
        .getDocuments();
    dynamic totalDocs = totalResult.documents.length;

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
