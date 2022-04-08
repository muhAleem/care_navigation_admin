import 'package:care_navigation_admin_panel/firebase/api_data.dart';
import 'package:care_navigation_admin_panel/widgets/custom_alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FolderListController extends GetxController {
  bool isLoading = true;
  List folderlist = [];
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
    folderlist.forEach((e) {
      if (e['title'].toString().toLowerCase().contains(v.toLowerCase())) {
        searchlist.add(e);
      } 

      update();
    });
  }

  Future<void> getData() async {
    try {
      searchlist.clear();
      folderlist.clear();
      var data = await ApiData.folder.get();
      data.docs.forEach((v) {
        folderlist.add(v.data());
      });
      update();
    } on FirebaseException catch (e) {
      CommonSnackbar.getSnackbar('Error', e.message.toString(), Colors.red);
    }
  }

  void deletefolder(String id) {
    ApiData.folder.doc(id).delete().then((value) async {
      isLoading = true;
      update();
      await getData();
      isLoading = false;
      update();
      CommonSnackbar.getSnackbar(
          'Success', 'Folder Deleted Successfully', Colors.green);
    });
  }
}
