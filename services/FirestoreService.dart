// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  FirebaseFirestore firebaseFirestoreInstance = FirebaseFirestore.instance;

  Future<void> addUpdateUser(id, name, username, password, emailAddress) {

    FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;

    return firestoreInstance.collection('users').doc(id).set({
      'id' : id,
      'name' : name,
      'username' : '${username}',
      'emailAddress' : emailAddress,
      'password' : password,
      'profileImageUrl' : "",
    });
  }

  Future<void> uploadImageUrl(String downloadUrl, String id) {
    return firebaseFirestoreInstance.collection('users').doc(id).update({
      'profileImageUrl' : downloadUrl
    });
  }

  Future<void> placeImageUrl(String downloadUrl, String placeName) {
    return firebaseFirestoreInstance.collection('campLocations').doc(placeName).update({
      'profileImageUrl' : downloadUrl
    });
  }

  Future<List> getLocationData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await firebaseFirestoreInstance.collection('location').get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    return allData;
  }
  






}



