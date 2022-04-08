import 'package:care_navigation_admin_panel/controller/auth/login_controller.dart';
import 'package:care_navigation_admin_panel/view/auth/forgetpassword/forget_password_screen.dart';
import 'package:care_navigation_admin_panel/widgets/app_button.dart';
import 'package:care_navigation_admin_panel/widgets/app_colors.dart';
import 'package:care_navigation_admin_panel/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'package:get/state_manager.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LogInController>(
      init: LogInController(),
      builder: (_) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: const Color(0xffE5E5E5),
            body: Center(
              child: _.isLoading
                  ? SizedBox(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: LoadingAnimationWidget.threeRotatingBalls(
                          color: AppColors.redcolor,
                          size: 50,
                        ),
                      ),
                    )
                  : Container(
                      height: Get.height,
                      width: Get.width,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background.jpg'),
                              fit: BoxFit.cover)),
                      child: SingleChildScrollView(
                        child: Card(
                          shadowColor: Colors.grey,
                          elevation: 10,
                          color: Colors.white,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              GestureDetector(
                                onLongPress: () {
                                  _.createAccount();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10),
                                  // child: Image.asset('assets/header_image.svg'),
                                  child: Image.asset(
                                    'assets/images/app_logo.png',
                                    height: 70,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Welcome To Admin Panel',
                                style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Log In',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 39),
                                child: CommonTextFormField1(
                                    _.email,
                                    'Enter Email',
                                    'Email',
                                    false,
                                    TextInputType.name, (value) {
                                  Pattern pattern =
                                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  var regex = RegExp(pattern as String);
                                  return (!regex.hasMatch(value!))
                                      ? 'Please enter valid email'
                                      : null;
                                }, 1),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 39),
                                child: CommonTextFormField1(
                                  _.password,
                                  'Enter password',
                                  'Password',
                                  _.obscurePassword,
                                  TextInputType.name,
                                  (value) {
                                    return (value!.isEmpty)
                                        ? 'Password can not be empty'
                                        : null;
                                  },
                                  1,
                                  showSuffix: true,
                                  changeObscureStatus: () {
                                    _.changeObscurePassword();
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Checkbox(
                                      value: _.rememberMe,
                                      onChanged: (bool? value) {
                                        _.rememberMe = value!;
                                        _.update();
                                      },
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text('Remember me'),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(ResetPassword());
                                      },
                                      child: const Text(
                                        'Forget Password',
                                        style: TextStyle(
                                            color: AppColors.redcolor),
                                      ),
                                    ).marginOnly(right: 30)
                                  ]),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularButtons(
                                    backgroundColor: AppColors.redcolor,
                                    borderColor: AppColors.redcolor,
                                    text: "Log In".toUpperCase(),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width *
                                        0.2,
                                    onPressed: () {
                                      _.getLogin();
                                    },
                                    textColor: Colors.white,
                                    textStyle: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ).marginOnly(left: 360, right: 360, top: 40),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
