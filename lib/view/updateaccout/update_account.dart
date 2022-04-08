import 'dart:convert';

import 'package:care_navigation_admin_panel/controller/updateaccount/update_account_controller.dart';
import 'package:care_navigation_admin_panel/widgets/app_button.dart';
import 'package:care_navigation_admin_panel/widgets/app_colors.dart';
import 'package:care_navigation_admin_panel/widgets/app_textfield.dart';
import 'package:care_navigation_admin_panel/widgets/custom_alerts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UpdateAccount extends StatelessWidget {
  const UpdateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateAccountController>(
      init: UpdateAccountController(),
      builder: (_) {
        return _.isLoading
            ? Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: LoadingAnimationWidget.threeRotatingBalls(
                    color: AppColors.redcolor,
                    size: 50,
                  ),
                ),
              )
            : SafeArea(
                child: Scaffold(
                  backgroundColor: AppColors.backgroundcolor,
                  body: Center(
                    child: _.isLoading
                        ? Center(
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: LoadingAnimationWidget.threeRotatingBalls(
                                color: AppColors.redcolor,
                                size: 50,
                              ),
                            ),
                          )
                        : SizedBox(
                            height: Get.height,
                            width: Get.width * 0.4,
                            child: SingleChildScrollView(
                              child: Card(
                                shadowColor: Colors.grey,
                                elevation: 10,
                                color: Colors.white,
                                child: Form(
                                  key: _.formkey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Image.asset(
                                            "assets/images/app_logo.png"),
                                      ),
                                      const Text("Update Account",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                              width: Get.width / 3.0,
                                              child: Center(
                                                child: Stack(
                                                  alignment: Alignment.topRight,
                                                  children: [
                                                    Container(
                                                      height: 150,
                                                      width: 150,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color: Colors.blue,
                                                          width: 4,
                                                        ),
                                                      ),
                                                      child: InkWell(
                                                        child: CircleAvatar(
                                                          backgroundColor:
                                                              Colors.grey,
                                                          backgroundImage:
                                                              _.pictureController3 !=
                                                                          null &&
                                                                      _.pictureController3 !=
                                                                          ''
                                                                  ? MemoryImage(
                                                                      base64Decode(
                                                                        _.pictureController3,
                                                                      ),
                                                                    )
                                                                  : null,
                                                          radius:
                                                              Get.width / 8.5,
                                                          child: _.pictureController3 !=
                                                                      null &&
                                                                  _.pictureController3 !=
                                                                      ''
                                                              ? null
                                                              : const Icon(
                                                                  Icons
                                                                      .perm_identity,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 50,
                                                                ),
                                                        ),
                                                        onTap: () {
                                                          _.uploadProfile(
                                                              context);
                                                        },
                                                      ),
                                                    ),
                                                    InkWell(
                                                      child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                            color: Colors.blue,
                                                            width: 2,
                                                          ),
                                                          color: Colors.white,
                                                        ),
                                                        child: const Icon(
                                                            Icons.edit,
                                                            size: 20),
                                                      ).paddingOnly(
                                                          right: 0, top: 0),
                                                      onTap: () {
                                                        _.uploadProfile(
                                                            context);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 39),
                                        child: CommonTextFormField1(
                                          _.fNameController,
                                          'Enter first name',
                                          'First Name',
                                          false,
                                          TextInputType.name,
                                          (value) {
                                            return (value!.trim().isEmpty)
                                                ? "First Name can't be Empty"
                                                : null;
                                          },
                                          1
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 39),
                                        child: CommonTextFormField1(
                                          _.lNameController,
                                          'Enter last name',
                                          'Last Name',
                                          false,
                                          TextInputType.name,
                                          (value) {
                                            return (value!.trim().isEmpty)
                                                ? "Last Name can't be Empty"
                                                : null;
                                          },
                                          1
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 39),
                                        child: CommonTextFormField1(
                                          _.emailController,
                                          'Email',
                                          'Email',
                                          false,
                                          TextInputType.name,
                                          (value) {
                                            return (value!.isEmpty)
                                                ? "Email can't be Empty"
                                                : null;
                                          },
                                          1,
                                          readOnly: true,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                CircularButtons(
                                                    backgroundColor:
                                                        AppColors.redcolor,
                                                    borderColor:
                                                        AppColors.redcolor,
                                                    text: "SAVE",
                                                    height: 50,
                                                    width: Get.width * 0.2,
                                                    textColor: Colors.white,
                                                    textStyle:
                                                        const TextStyle(),
                                                    onPressed: () {
                                                      if (_
                                                          .validateAndSaveUser()) {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                  shape: const RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              20.0))),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  content:
                                                                      SizedBox(
                                                                    height: 200,
                                                                    width: 400,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: const [
                                                                            Text(
                                                                              'Are you sure to update account',
                                                                              style: TextStyle(
                                                                                  // color:
                                                                                  // fButtonColor,
                                                                                  fontSize: 25,
                                                                                  fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            CircularButtons(
                                                                              backgroundColor: AppColors.redcolor,
                                                                              borderColor: AppColors.redcolor,
                                                                              text: "Yes",
                                                                              height: 50,
                                                                              width: Get.width * 0.1,
                                                                              textColor: Colors.white,
                                                                              textStyle: const TextStyle(),
                                                                              onPressed: () async {
                                                                                _.addProfile(context);
                                                                              },
                                                                            ),
                                                                            CircularButtons(
                                                                              backgroundColor: AppColors.greycolor,
                                                                              borderColor: AppColors.greycolor,
                                                                              text: "No",
                                                                              height: 50,
                                                                              width: Get.width * 0.1,
                                                                              textColor: Colors.white,
                                                                              textStyle: const TextStyle(),
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ));
                                                            });
                                                      } else {
                                                        CustomAlertDialog
                                                            .showAlertDialog(
                                                                title:
                                                                    "Warning",
                                                                message:
                                                                    "Please Fill all fields",
                                                                backgroundColor:
                                                                    Colors
                                                                        .white);
                                                      }
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              );
      },
    );
  }
}
