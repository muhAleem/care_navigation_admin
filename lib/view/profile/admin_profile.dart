import 'dart:convert';

import 'package:care_navigation_admin_panel/controller/auth/auth_controller.dart';
import 'package:care_navigation_admin_panel/controller/profile_controller.dart/profile_controller.dart';
import 'package:care_navigation_admin_panel/widgets/app_button.dart';
import 'package:care_navigation_admin_panel/widgets/app_colors.dart';
import 'package:care_navigation_admin_panel/widgets/app_textfield.dart';
import 'package:care_navigation_admin_panel/widgets/custom_alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  PageController page = PageController(keepPage: false);

  final authController1 = Get.put(AuthController());
  final authController = Get.find<AuthController>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool validateAndSaveUser() {
    final form = formkey.currentState;
    form!.save();
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (_) {
          return Container(
            padding: const EdgeInsets.all(25),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          page.jumpToPage(10);
                        },
                        child: Row(
                          children: const [],
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${_.firstName} ${_.lastName}',
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  PopupMenuButton(
                    offset: const Offset(0, 40),
                    child: const Center(
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 20,
                      ),
                    ),
                    itemBuilder: (context) {
                      return List.generate(_.headerOptions.length, (index) {
                        return PopupMenuItem(
                          value: index,
                          child: Row(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    _.logoutfun();
                                  },
                                  child: Icon(index == 1
                                      ? Icons.power_settings_new
                                      : Icons.change_circle)),
                              const SizedBox(
                                width: 5,
                              ),
                              Text('${_.headerOptions[index]}'),
                            ],
                          ),
                        );
                      });
                    },
                    onSelected: (index) {
                      if (index == 0) {
                        // page.jumpToPage(9);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: SizedBox(
                                  width: width * 0.4,
                                  child: Card(
                                    shadowColor: Colors.grey,
                                    elevation: 10,
                                    color: Colors.white,
                                    margin: EdgeInsets.zero,
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      padding: const EdgeInsets.all(15),
                                      children: [
                                        Image.asset(
                                          'assets/images/app_logo.png',
                                          height: 70,
                                        ),
                                        const Text(
                                          'ChangePassword',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black),
                                        ),
                                        const SizedBox(height: 30),
                                        Form(
                                          key: formkey,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              children: [
                                                Obx(() {
                                                  return CommonTextFormField1(
                                                    passwordController,
                                                    'Enter Old Password',
                                                    'Old Password',
                                                    _.obscureOldPassword.value,
                                                    TextInputType.name,
                                                    (value) {
                                                      return (value!.isEmpty)
                                                          ? 'This field is requqired'
                                                          : null;
                                                    },
                                                    1,
                                                    showSuffix: true,
                                                    changeObscureStatus: () {
                                                      _.changeOldPassword();
                                                    },
                                                  );
                                                }),
                                                const SizedBox(height: 30),
                                                Obx(() {
                                                  return Row(
                                                    children: [
                                                      Expanded(
                                                        child:
                                                            CommonTextFormField1(
                                                          newpasswordController,
                                                          'Enter New Password',
                                                          'New Password',
                                                          _.obscureNewPassword
                                                              .value,
                                                          TextInputType.name,
                                                          (value) {},
                                                          1,
                                                          showSuffix: true,
                                                          changeObscureStatus:
                                                              () {
                                                            _.changeNewPassword();
                                                          },
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(
                                                          Icons.info,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                                const SizedBox(height: 30),
                                                Obx(() {
                                                  return CommonTextFormField1(
                                                    confirmpasswordController,
                                                    'Confirm New Password',
                                                    'Confirm New Password',
                                                    _.obscureConfirmPassword
                                                        .value,
                                                    TextInputType.name,
                                                    (value) {
                                                      if (value.isEmpty) {
                                                        return 'This field is requqired';
                                                      }
                                                      
                                                      if (value !=
                                                          newpasswordController
                                                              .text) {
                                                        return 'passwordNotMatch';
                                                      }
                                                      return null;
                                                    },
                                                    1,
                                                    showSuffix: true,
                                                    changeObscureStatus: () {
                                                      _.changeConfirmPassword();
                                                    },
                                                  );
                                                }),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            CircularButtons(
                                              backgroundColor:
                                                  AppColors.redcolor,
                                              borderColor: AppColors.redcolor,
                                              text: 'Update',
                                              height: 50,
                                              width: Get.width >= 720
                                                  ? width * 0.2
                                                  : width * 0.4,
                                              onPressed: () {
                                                if (validateAndSaveUser()) {
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                            shape:
                                                                const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    20.0),
                                                              ),
                                                            ),
                                                            backgroundColor:
                                                                Colors.white,
                                                            content: SizedBox(
                                                              height: 200,
                                                              width: 400,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: const [
                                                                      Text(
                                                                        'Do You Want To Update Password',
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                25,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      CircularButtons(
                                                                        backgroundColor:
                                                                            AppColors.redcolor,
                                                                        borderColor:
                                                                            AppColors.redcolor,
                                                                        text:
                                                                            'Yes',
                                                                        height:
                                                                            50,
                                                                        width: width *
                                                                            0.1,
                                                                        textColor:
                                                                            Colors.white,
                                                                        textStyle:
                                                                            const TextStyle(),
                                                                        onPressed:
                                                                            () {
                                                                          authController.changePassword(
                                                                              passwordController.text,
                                                                              newpasswordController.text);
                                                                          formkey
                                                                              .currentState!
                                                                              .reset();
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      ),
                                                                      CircularButtons(
                                                                        backgroundColor:
                                                                            AppColors.greycolor,
                                                                        borderColor:
                                                                            AppColors.greycolor,
                                                                        text:
                                                                            'No',
                                                                        height:
                                                                            50,
                                                                        width: width *
                                                                            0.1,
                                                                        textColor:
                                                                            Colors.white,
                                                                        textStyle:
                                                                            const TextStyle(),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ));
                                                      });
                                                } else {
                                                  CustomAlertDialog.showAlertDialog(
                                                      title: 'warning',
                                                      message:
                                                          'Please Fill All Fields',
                                                      backgroundColor:
                                                          Colors.white);
                                                }
                                              },
                                              textColor: Colors.white,
                                              textStyle: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else if (index == 1) {
                        _.logoutfun();
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      Container(
                        width: 45.0,
                        height: 45.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                            radius: 45.0,
                            backgroundImage: _.pic.isEmpty
                                ? null
                                : MemoryImage(base64Decode(_.pic)),
                            child: _.pic.isEmpty
                                ? IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.person))
                                : null),
                      ),
                    ],
                  ),
                ],
              )
            ]),
          );
        });
  }
}
