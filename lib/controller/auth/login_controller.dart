import 'package:care_navigation_admin_panel/constants/routes/app_routes.dart';
import 'package:care_navigation_admin_panel/firebase/api_data.dart';
import 'package:care_navigation_admin_panel/widgets/app_sidemenu.dart';
import 'package:care_navigation_admin_panel/widgets/custom_alerts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool rememberMe = false;
  bool obscurePassword = true;
  bool isLoading = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final storage = GetStorage();
  SharedPreferences? prefs;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
  }

  void changeObscurePassword() {
    obscurePassword = !obscurePassword;
    update();
  }

  @override
  void onReady() async {
    isLoading = false;
    prefs = await SharedPreferences.getInstance();
    await getRememberMeUser();

    update();
    super.onReady();
  }

  Future<void> getLoginWithStorage() async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
              email: storage.read('username').toString(),
              password: storage.read('password').toString())
          .then((result) async {
        var user = firebaseAuth.currentUser;
        if (user!.emailVerified) {
          Get.to(SideBar());
        } else {
          await user.sendEmailVerification();
          // isLoading = false;
          // update();
          CustomAlertDialog.showAlertDialog(
              title: 'Warning',
              message: 'Please Verify Your Email',
              backgroundColor: Colors.white);
        }
      });
    } on FirebaseAuthException catch (e) {
      // isLoading = false;
      // update();
      // LoggingService().fine('Login User Exception', e.toString());
      CustomAlertDialog.showAlertDialog(
          title: 'Warning',
          message: e.message.toString(),
          backgroundColor: Colors.white);
    }
  }

  Future<void> getRememberMeUser() async {
    if (prefs != null) {
      email.text = prefs!.getString('email') ?? '';
      password.text = prefs!.getString('password') ?? '';
      rememberMe = prefs!.getBool('rememberMe') ?? false;
    }
  }

  Future<void> createAccount() async {
    isLoading = true;
    update();
    try {
      ApiData.firebaseAuth
          .createUserWithEmailAndPassword(
              email: 'moeezeee460@gmail.com', password: '123456')
          .then((result) async {
        var user = result.user!;
        await user.sendEmailVerification();
        await ApiData.admin.doc(result.user!.uid).set({
          'uid': result.user!.uid,
          'firstName': 'Moeez',
          'lastName': 'Suleman',
          'email': "moeezeee460@gmail.com",
          'atrole': 'admin',
          'createdAt': Timestamp.now(),
        });
      }).then((value) async {
        // var user = ApiData.firebaseAuth.currentUser;
        // await user!.sendEmailVerification();
        isLoading = false;
        update();
        CustomAlertDialog.showAlertDialog(
            title: 'Success',
            message:
                'Account Created Succesfully\n Please Verify Your Email first to login ',
            backgroundColor: Colors.white);
      });
    } on FirebaseAuthException catch (q) {
      isLoading = false;
      update();
      CustomAlertDialog.showAlertDialog(
          title: 'Error',
          message: q.message.toString(),
          backgroundColor: Colors.white);

      // CommonSnackbar.getSnackbar('Error', q.message.toString(), Colors.red);

    } on FirebaseException catch (e) {
      isLoading = false;
      update();
      CustomAlertDialog.showAlertDialog(
          title: 'Error',
          message: e.message.toString(),
          backgroundColor: Colors.white);
      //CommonSnackbar.getSnackbar('Error', e.message.toString(), Colors.red);
    } catch (w) {
      isLoading = false;
      update();
      CustomAlertDialog.showAlertDialog(
          title: 'Warning',
          message: w.toString(),
          backgroundColor: Colors.white);
      //CommonSnackbar.getSnackbar('Error', w.toString(), Colors.red);
    }
  }

  Future<void> getLogin() async {
    print('EMail is ${email.text}');
    isLoading = true;
    update();
    try {
      UserCredential _creds = await ApiData.firebaseAuth
          .signInWithEmailAndPassword(
              email: email.text, password: password.text);
      if (_creds.user != null) {
        if (_creds.user!.emailVerified) {
          DocumentSnapshot _userDoc =
              await ApiData.admin.doc(_creds.user!.uid).get();
          if (_userDoc.data() != null) {
            Map _userData = _userDoc.data() as Map;
            if (_userData['atrole'].toString().toLowerCase() == 'admin') {
              Get.to(const SideBar());
            } else {
              await ApiData.firebaseAuth.signOut();
            }
          } else {
            await ApiData.firebaseAuth.signOut();
            CommonSnackbar.getSnackbar(
                'Error', 'Account does not exist', Colors.red);
          }
        } else {
          _creds.user!.sendEmailVerification();
          CommonSnackbar.getSnackbar(
              'Error', 'Please verify your email first to login', Colors.red);
        }
      } else {
        CommonSnackbar.getSnackbar(
            'Error', 'Account does not exist', Colors.red);
      }
    } on FirebaseAuthException catch (e) {
      CommonSnackbar.getSnackbar('Error', e.message.toString(), Colors.red);
    } on FirebaseException catch (e) {
      CommonSnackbar.getSnackbar('Error', e.message.toString(), Colors.red);
    } catch (e) {
      CommonSnackbar.getSnackbar('Error', e.toString(), Colors.red);
    } finally {
      isLoading = false;
      update();
    }
  }
}
