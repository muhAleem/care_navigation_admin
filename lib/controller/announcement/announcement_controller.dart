import 'package:care_navigation_admin_panel/firebase/api_data.dart';
import 'package:care_navigation_admin_panel/widgets/custom_alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnnouncementScreenController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController title = TextEditingController();
  TextEditingController search = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
 
  

  @override
  void onReady() async {
    isLoading = false;

    update();
    super.onReady();
  }

  

  Future<void> addData() async {
    isLoading = true;
    update();
    try {
      var data = ApiData.announcement.doc();
      var docSnap = await data.get();
      data.set({
        'id': docSnap.reference.id,
        'name': title.text,
        'createdAt': DateTime.now(),
      }).then((value) {
        title.clear();

        isLoading = false;
        update();
        CommonSnackbar.getSnackbar(
          'Success',
          'Announcement added successfully',
          Colors.green,
        );
      });
    } on FirebaseException catch (e) {
      isLoading = false;
      update();
      CommonSnackbar.getSnackbar('Error', e.message.toString(), Colors.red);
    }
  }
}
