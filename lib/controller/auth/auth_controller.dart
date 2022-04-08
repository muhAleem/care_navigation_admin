import 'package:care_navigation_admin_panel/view/auth/login/login.dart';
import 'package:care_navigation_admin_panel/widgets/custom_alerts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser.obs;
  final storage = GetStorage();
  @override
  void onInit() {
    super.onInit();
  }

  // CHECKING DUPLICATE EMAIL
  Future<List<String>> checkDuplicateEmail(String email) async {
    try {
      return await _auth.fetchSignInMethodsForEmail(email);
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

  void changePassword(String currentPassword, String newPassword) async {
    final cred = EmailAuthProvider.credential(
        email: _auth.currentUser!.email!, password: currentPassword);

    _auth.currentUser!.reauthenticateWithCredential(cred).then((value) {
      _auth.currentUser!.updatePassword(newPassword).then((_) {
        CustomSnackBar.showSnackBar(
            title: 'successPasswordUpdated',
            message: '',
            backgroundColor: Colors.green);
        logoutfun();
      }).catchError((error) {
        CustomAlertDialog.showAlertDialog(
            title: 'Warning',
            message: 'SomeThing Went Wrong',
            backgroundColor: Colors.white);
      });
    }).catchError((err) {
      CustomAlertDialog.showAlertDialog(
          title: 'Warning',
          message: 'Old password is not correct',
          backgroundColor: Colors.white);
    });
  }

  void saveUserState(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', uid);
  }

  Future getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  Future<void> logoutfun() async {
    await FirebaseAuth.instance.signOut().then((value) async {
      await storage.remove('username');
      await storage.remove('password');
      Get.offAll(() => const Login());
    });
  }
}
