import 'package:care_navigation_admin_panel/firebase/api_data.dart';
import 'package:care_navigation_admin_panel/widgets/custom_alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserListController extends GetxController {
  bool isLoading = true;
  List userlist = [];
  List searchlist = [];

  TextEditingController search = TextEditingController();
  TextEditingController phone = TextEditingController();
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
    userlist.forEach((e) {
      if (e['email'].toString().toLowerCase().contains(v.toLowerCase())) {
        searchlist.add(e);
      } else if (e['username']
          .toString()
          .toLowerCase()
          .contains(v.toLowerCase())) {
        searchlist.add(e);
      } else if (e['phone'].toString().toLowerCase().contains(v.toLowerCase())) {
        searchlist.add(e);
      }

      update();
    });
  }

  Future<void> getData() async {
    try {
      searchlist.clear();
      userlist.clear();
      var data = await ApiData.users.get();
      data.docs.forEach((v) {
        userlist.add(v.data());
      });
      update();
    } on FirebaseException catch (e) {
      CommonSnackbar.getSnackbar('Error', e.message.toString(), Colors.red);
    }
  }

  Future<void> updateuser(String id) async {
    await ApiData.users.doc(id).update(
        {'username': firstname.text, 'email': email.text,"phone":phone.text}).then((value) async {
      isLoading = true;
      update();
      await getData();
      isLoading = false;
      update();
      CommonSnackbar.getSnackbar(
          'Success', 'User Delete Successfully', Colors.green);
    });
  }

  void deleteuser(String id) {
    ApiData.users.doc(id).delete().then((value) async {
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
