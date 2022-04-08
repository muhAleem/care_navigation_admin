import 'package:care_navigation_admin_panel/controller/create_folderc_ontroller.dart';
import 'package:care_navigation_admin_panel/view/profile/admin_profile.dart';
import 'package:care_navigation_admin_panel/widgets/app_button.dart';
import 'package:care_navigation_admin_panel/widgets/app_colors.dart';
import 'package:care_navigation_admin_panel/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class CreateFolder extends StatelessWidget {
  const CreateFolder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateFolderController>(
      init: CreateFolderController(),
      builder: (_) {
        return Scaffold(
          body: Column(
            children: [
              ProfileScreen(),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      'Add Folder',
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                'Add Folder',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                key: _.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 39),
                      child: CommonTextFormField1(
                        _.title,
                        'Enter Folder Name',
                        'Folder Name',
                        false,
                        TextInputType.name,
                        (value) {
                          return (value!.isEmpty)
                              ? 'Folder Name can not be empty'
                              : null;
                        },
                        1,
                        showSuffix: false,
                        changeObscureStatus: () {
                          //_.changeObscurePassword();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularButtons(
                    backgroundColor: AppColors.redcolor,
                    borderColor: AppColors.redcolor,
                    text: "Add Folder",
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.2,
                    onPressed: () {
                      if (_.title.text.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                ),
                                backgroundColor: Colors.white,
                                content: SizedBox(
                                  height: 200,
                                  width: 500,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            'Are You sure to create this folder?',
                                            style: TextStyle(
                                                color: Colors.black,
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
                                            text: 'Yes',
                                            height: 50,
                                            width: 200,
                                            textColor: Colors.white,
                                            textStyle: const TextStyle(),
                                            onPressed: () {
                                              _.addData();

                                              Navigator.pop(context);
                                            },
                                          ),
                                          CircularButtons(
                                            backgroundColor:
                                                AppColors.greycolor,
                                            borderColor: AppColors.greycolor,
                                            text: 'No',
                                            height: 50,
                                            width: 200,
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
                          },
                        );
                        // _.addData();
                      } else {
                        Get.snackbar("Error", "Fill all fields",
                            backgroundColor: Colors.red);
                      }
                    },
                    textColor: Colors.white,
                    textStyle: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
