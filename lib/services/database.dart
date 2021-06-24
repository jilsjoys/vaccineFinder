import 'package:cloud_firestore/cloud_firestore.dart';

Future addProfile(fav) {
  return FirebaseFirestore.instance.collection('Favourite').add({"id": fav});
}
