import 'package:care_navigation_admin_panel/firebase/api_data.dart';
import 'package:care_navigation_admin_panel/widgets/custom_alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnnouncementListController extends GetxController {
  bool isLoading = true;
  List announcementlist = [];
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
    announcementlist.forEach((e) {
      if (e['name'].toString().toLowerCase().contains(v.toLowerCase())) {
        searchlist.add(e);
      }

      update();
    });
  }

  Future<void> getData() async {
    try {
      searchlist.clear();
      announcementlist.clear();
      var data = await ApiData.announcement.get();
      data.docs.forEach((v) {
        announcementlist.add(v.data());
      });
      update();
    } on FirebaseException catch (e) {
      CommonSnackbar.getSnackbar('Error', e.message.toString(), Colors.red);
    }
  }

  void deletenotice(String id) {
    ApiData.announcement.doc(id).delete().then((value) async {
      isLoading = true;
      update();
      await getData();
      isLoading = false;
      update();
      CommonSnackbar.getSnackbar(
          'Success', 'Announcement Deleted Successfully', Colors.green);
    });
  }
}
