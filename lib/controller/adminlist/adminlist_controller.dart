import 'package:care_navigation_admin_panel/firebase/api_data.dart';
import 'package:care_navigation_admin_panel/widgets/custom_alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDataController extends GetxController {
  bool isLoading = true;
  List adminlist = [];
  List searchlist = [];

  TextEditingController search = TextEditingController();
  TextEditingController firstname = TextEditingController();
  TextEditingController email = TextEditingController();

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
    adminlist.forEach((e) {
      if (e['email'].toString().toLowerCase().contains(v.toLowerCase())) {
        searchlist.add(e);
      } else if (e['firstName']
          .toString()
          .toLowerCase()
          .contains(v.toLowerCase())) {
        searchlist.add(e);
      } else if (e['uid'].toString().toLowerCase().contains(v.toLowerCase())) {
        searchlist.add(e);
      }

      update();
    });
  }

  Future<void> getData() async {
    try {
      searchlist.clear();
      adminlist.clear();
      var data = await ApiData.admin.get();
      data.docs.forEach((v) {
        adminlist.add(v.data());
      });
      update();
    } on FirebaseException catch (e) {
      CommonSnackbar.getSnackbar('Error', e.message.toString(), Colors.red);
    }
  }

  Future<void> updateuser(String id) async {
    await ApiData.admin.doc(id).update(
        {'firstName': firstname.text, 'email': email.text}).then((value) async {
      isLoading = true;
      update();
      await getData();
      isLoading = false;
      update();
      CommonSnackbar.getSnackbar(
          'Success', 'Data Delete Successfully', Colors.green);
    });
  }

  void deleteuser(String id) {
    ApiData.admin.doc(id).delete().then((value) async {
      isLoading = true;
      update();
      await getData();
      isLoading = false;
      update();
      CommonSnackbar.getSnackbar(
          'Success', 'Data Delete Successfully', Colors.green);
    });
  }
}
