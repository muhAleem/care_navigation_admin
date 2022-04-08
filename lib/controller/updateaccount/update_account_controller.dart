import 'dart:convert';
import 'dart:typed_data';

import 'package:care_navigation_admin_panel/model/admin_model.dart';
import 'package:care_navigation_admin_panel/widgets/custom_alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class UpdateAccountController extends GetxController {
  bool isLoading = true;

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String pictureController3 = "";

  FilePickerResult? uploadPhoto;

  final ImagePicker picker3 = ImagePicker();
  BuildContext? context;
  int maxFileSize = 500 * 1024; // in bytes 500 kb
  int signatureFileSize = 100 * 1024; // 100 kb

  final profiledb = FirebaseFirestore.instance.collection("Admin");

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    await getProfile();
    isLoading = false;
    update();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  uploadProfile(BuildContext context) async {
    uploadPhoto = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: false);
    if (uploadPhoto != null) {
      int size = uploadPhoto!.files.single.size;
      if (size == 0) {
        showSnackBar(size, maxFileSize);
      } else {
        final data = await checkFileSize(
            size, context, uploadPhoto!.files.single.bytes!);
        if (data != null) {
          pictureController3 = base64Encode(data);
          print(pictureController3);
          update();
        }
      }
    }
   
  }

  bool validateAndSaveUser() {
    final form = formkey.currentState;
    form!.save();
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

 

  void showSnackBar(int size, int maxSize) {
    if (size == 0) {
    
      CustomAlertDialog.showAlertDialog(
          title: "Warning",
          message: "File Size cannot be zero",
          backgroundColor: Colors.white);
    } else {
     
      CustomAlertDialog.showAlertDialog(
          title: "Warning",
          message: "Image must be less than ${maxSize / (1024)} kB",
          backgroundColor: Colors.white);
    }
  }

 

  String checkKey(String key, var data) {
    bool contains = data.data().containsKey(key);
    if (contains) {
      return data.data()![key];
    }
    return '';
  }

  Future<AdminDetailModel> getProfile() async {
    var udata =
        await profiledb.doc(FirebaseAuth.instance.currentUser!.uid).get();
    if (udata.exists) {
      fNameController.text = checkKey('firstName', udata);
      lNameController.text = checkKey('lastName', udata);
      pictureController3 = checkKey('imageUrl', udata);
      emailController.text = checkKey('email', udata);

      update();
      final adminDetail = AdminDetailModel(
        firstName: fNameController.text.capitalize!,
        lastName: lNameController.text.capitalize!,
        profileImage: pictureController3,
        email: emailController.text.capitalize!,
      );
      return adminDetail;
    }
    return AdminDetailModel(
        firstName: '', lastName: '', profileImage: '', email: '');
  }

  static Future<List<int>?> checkFileSize(
      int size, BuildContext context, Uint8List file) async {
    
    return Future.value(file);
  }

  Future<void> addProfile(BuildContext context) async {
    Get.back();
    // WaitDialog.progressDialog(true, context);

    isLoading = true;
    update();
    await profiledb.doc(FirebaseAuth.instance.currentUser!.uid).update({
      "uid": FirebaseAuth.instance.currentUser!.uid,
      "firstName": fNameController.text,
      "lastName": lNameController.text,
      "imageUrl": pictureController3,
    }).then((value) async {
      await getProfile();
      isLoading = false;
      update();
      CustomSnackBar.showSnackBar(
        title: "Success",
        message: 'Profile Added Successfully',
        backgroundColor: Colors.green,
      );
      // WaitDialog.progressDialog(false, context);
    });
  }


  
}
