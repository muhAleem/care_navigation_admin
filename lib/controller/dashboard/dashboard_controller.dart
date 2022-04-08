// ignore_for_file: unnecessary_overrides

import 'package:care_navigation_admin_panel/firebase/api_data.dart';
import 'package:care_navigation_admin_panel/widgets/custom_alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  bool isLoading = true;

  List adminList = [];
  List usersList = [];
  List noticeList = [];
  List announcementList = [];
  List policyList = [];
  List assessmentList = [];

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    await getadminData();
    await getuserData();
    await gettitleData();
    await getannouncementData();
    await getpolicyData();
    await getassessmentData();

    isLoading = false;
    update();
    super.onReady();
    // ignore: avoid_print
    print("Not deleted");
  }

  @override
  // ignore: unnecessary_overrides
  void onClose() {
    super.onClose();
  }

  Future<void> getadminData() async {
    try {
      adminList.clear();
      var data = await ApiData.admin.get();
      // ignore: avoid_function_literals_in_foreach_calls
      data.docs.forEach((v) {
        adminList.add(v.data());
      });
      update();
    } on FirebaseException catch (e) {
      CommonSnackbar.getSnackbar('Error', e.message.toString(), Colors.red);
    }
  }

  Future<void> getuserData() async {
    try {
      usersList.clear();
      var data = await ApiData.users.get();
      // ignore: avoid_function_literals_in_foreach_calls
      data.docs.forEach((v) {
        usersList.add(v.data());
      });
      update();
    } on FirebaseException catch (e) {
      CommonSnackbar.getSnackbar('Error', e.message.toString(), Colors.red);
    }
  }

  Future<void> gettitleData() async {
    try {
      noticeList.clear();
      var data = await ApiData.notice.get();
      // ignore: avoid_function_literals_in_foreach_calls
      data.docs.forEach((v) {
        noticeList.add(v.data());
      });
      update();
    } on FirebaseException catch (e) {
      CommonSnackbar.getSnackbar('Error', e.message.toString(), Colors.red);
    }
  }

  Future<void> getannouncementData() async {
    try {
      announcementList.clear();
      var data = await ApiData.announcement.get();
      // ignore: avoid_function_literals_in_foreach_calls
      data.docs.forEach((v) {
        announcementList.add(v.data());
      });
      update();
    } on FirebaseException catch (e) {
      CommonSnackbar.getSnackbar('Error', e.message.toString(), Colors.red);
    }
  }

  Future<void> getpolicyData() async {
    try {
      policyList.clear();
      var data = await ApiData.policy.get();
      // ignore: avoid_function_literals_in_foreach_calls
      data.docs.forEach((v) {
        policyList.add(v.data());
      });
      update();
    } on FirebaseException catch (e) {
      CommonSnackbar.getSnackbar('Error', e.message.toString(), Colors.red);
    }
  }

   Future<void> getassessmentData() async {
    try {
      assessmentList.clear();
      var data = await ApiData.assessment.get();
      // ignore: avoid_function_literals_in_foreach_calls
      data.docs.forEach((v) {
        assessmentList.add(v.data());
      });
      update();
    } on FirebaseException catch (e) {
      CommonSnackbar.getSnackbar('Error', e.message.toString(), Colors.red);
    }
  }
}
