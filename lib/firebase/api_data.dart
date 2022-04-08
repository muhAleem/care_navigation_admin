import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiData {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static CollectionReference admin =
      FirebaseFirestore.instance.collection("Admin");
  static CollectionReference users =
      FirebaseFirestore.instance.collection("Users");
  static CollectionReference notice =
      FirebaseFirestore.instance.collection("Notice");
  static CollectionReference announcement =
      FirebaseFirestore.instance.collection("Announcement");
  static CollectionReference policy =
      FirebaseFirestore.instance.collection("Policy");
  static CollectionReference assessment =
      FirebaseFirestore.instance.collection("Assessment");
  static CollectionReference folder =
      FirebaseFirestore.instance.collection("Folder");

  static CollectionReference pdf =
      FirebaseFirestore.instance.collection("PdfData");

  static CollectionReference comments =
      FirebaseFirestore.instance.collection("Comment");
}
