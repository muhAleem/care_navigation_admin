import 'package:care_navigation_admin_panel/view/auth/login/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  String pic = '';
  String firstName = '';
  String lastName = '';
  String email = '';

  final storage = GetStorage();

  final clientprofiledb = FirebaseFirestore.instance.collection("Admin");
  List<String> headerOptions = ['Change Password', 'Logout'];

  var obscureOldPassword = true.obs;
  var obscureNewPassword = true.obs;
  var obscureConfirmPassword = true.obs;

  void changeOldPassword() {
    obscureOldPassword.value = !obscureOldPassword.value;
    update();
  }

  void changeNewPassword() {
    obscureNewPassword.value = !obscureNewPassword.value;
    update();
  }

  void changeConfirmPassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    await getProfile();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getProfile() async {
    try {
      var udata = await clientprofiledb
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (udata.exists) {
        pic = checkKey('imageUrl', udata);
        firstName = checkKey('firstName', udata);
        lastName = checkKey('lastName', udata);

        email = checkKey('email', udata);
        update();
      }
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  String checkKey(String key, var data) {
    bool contains = data.data().containsKey(key);
    if (contains) {
      return data.data()![key];
    }
    return '';
  }

  Future<void> logoutfun() async {
    await FirebaseAuth.instance.signOut().then((value) async {
      await storage.remove('username');
      await storage.remove('password');
      Get.to(const Login());
    });
  }
}
