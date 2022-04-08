import 'package:care_navigation_admin_panel/firebase/api_data.dart';
import 'package:care_navigation_admin_panel/widgets/custom_alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsController extends GetxController {
  bool isLoading = false;

  List commentlist = [];
  List searchlist = [];

  TextEditingController search = TextEditingController();

  @override
  void onReady() async {
    await getComments();
    isLoading = false;
    update();
    super.onReady();
  }

  

  Future<void> getComments() async {
    Stream<QuerySnapshot> streambodytarget =
        ApiData.comments.orderBy("createdAt", descending: true).snapshots();
    await streambodytarget.forEach((e) {
      commentlist.clear();
      for (var value in e.docs) {
        print(value.data());
        commentlist.add(value.data());
      }
      update();
    }).catchError((e) {
      print(e);
    });
  }

  void deletecomment(String id) {
    ApiData.comments.doc(id).delete().then((value) async {
      isLoading = false;
      update();
      await getComments();
      isLoading = false;
      update();
      CommonSnackbar.getSnackbar(
          'Success', 'Comment Deleted Successfully', Colors.green);
    });
  }
}
