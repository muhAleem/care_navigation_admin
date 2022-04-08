// ignore_for_file: deprecated_member_use

import 'package:care_navigation_admin_panel/widgets/app_button.dart';
import 'package:care_navigation_admin_panel/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class CustomSnackBar {
  static void showSnackBar({
    required String title,
    required String message,
    required Color backgroundColor,
  }) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: backgroundColor,
        titleText: Text(
          title,
          style: const TextStyle(fontSize: 16),
        ),
        messageText: Text(
          message,
          style: const TextStyle(fontSize: 16),
        ),
        colorText: Colors.white,
        borderRadius: 8,
        margin: const EdgeInsets.all(16));
  }
}

class CustomAlertDialog {
  static void showAlertDialog({
    required String title,
    required String message,
    required Color backgroundColor,
  }) {
    Get.defaultDialog(
        barrierDismissible: true,
        contentPadding: const EdgeInsets.all(5),
        content: Container(
          height: 260,
          width: 450,
          color: backgroundColor,
          child: Column(
            children: [
              Image.asset('assets/images/app_logo.png', height: 60),
              const SizedBox(
                height: 30,
              ),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: AppColors.greycolor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 30),
              CircularButtons(
                backgroundColor: AppColors.redcolor,
                borderColor: AppColors.redcolor,
                text: 'OK',
                height: 50,
                width: 200,
                // ignore: unnecessary_lambdas
                onPressed: () {
                  Get.back();
                },
                textColor: Colors.white,
                textStyle:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ));
  }

  static void showSuccessDialog({
    required String title,
    required String message,
    required Color backgroundColor,
  }) {
    Get.defaultDialog(
        title: '',
        contentPadding: const EdgeInsets.all(5),
        content: Container(
          height: 260,
          width: 450,
          color: backgroundColor,
          child: Column(
            children: [
              Image.asset('assets/images/app_logo.png', height: 60),
              const SizedBox(
                height: 30,
              ),
              Text(
                title,
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(message,
                  style: const TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 30),
              CircularButtons(
                backgroundColor: const Color(0xfffc6359),
                borderColor: const Color(0xfffc6359),
                text: 'Ok',
                height: 50,
                width: 200,
                // ignore: unnecessary_lambdas
                onPressed: () {
                  Get.back();
                },
                textColor: Colors.white,
                textStyle:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ));
  }
}

class CommonSnackbar {
  static void getSnackbar(String title, String message, Color snackbarColor) {
    Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: snackbarColor,
    );
  }
}

void openDialog(context, title, message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.all(50),
          elevation: 0,
          children: <Widget>[
            Text(title,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w900)),
            const SizedBox(
              height: 10,
            ),
            Text(message,
                style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 16,
                    fontWeight: FontWeight.w700)),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                color: Colors.deepPurpleAccent,
                child: const Text(
                  'Okay',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        );
      });
}



//sort length
