import 'package:care_navigation_admin_panel/firebase/api_data.dart';
import 'package:care_navigation_admin_panel/widgets/custom_alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssessmentListController extends GetxController {
  bool isLoading = true;
  List assessmentlist = [];
  List searchlist = [];

  TextEditingController search = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    await getData();
    isLoading = false;
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  searchFunction(String v) {
    searchlist = [];
    assessmentlist.forEach((e) {
      if (e['title'].toString().toLowerCase().contains(v.toLowerCase())) {
        searchlist.add(e);
      } else if (e['subtitle']
          .toString()
          .toLowerCase()
          .contains(v.toLowerCase())) {
        searchlist.add(e);
      }

      update();
    });
  }

  Future<void> getData() async {
    try {
      searchlist.clear();
      assessmentlist.clear();
      var data = await ApiData.assessment.get();
      data.docs.forEach((v) {
        assessmentlist.add(v.data());
      });
      update();
    } on FirebaseException catch (e) {
      CommonSnackbar.getSnackbar('Error', e.message.toString(), Colors.red);
    }
  }

  void deleteassessment(String id) {
    ApiData.assessment.doc(id).delete().then((value) async {
      isLoading = true;
      update();
      await getData();
      isLoading = false;
      update();
      CommonSnackbar.getSnackbar(
          'Success', 'Assessment Deleted Successfully', Colors.green);
    });
  }
}
