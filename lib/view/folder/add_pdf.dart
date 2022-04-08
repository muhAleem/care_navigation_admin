import 'package:care_navigation_admin_panel/controller/folder/add_pdf_controller.dart';
import 'package:care_navigation_admin_panel/view/profile/admin_profile.dart';
import 'package:care_navigation_admin_panel/widgets/app_button.dart';
import 'package:care_navigation_admin_panel/widgets/app_colors.dart';
import 'package:care_navigation_admin_panel/widgets/app_textfield.dart';
import 'package:care_navigation_admin_panel/widgets/common_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddPdf extends StatelessWidget {
  const AddPdf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UploadPdfController>(
      init: UploadPdfController(),
      builder: (_) {
        return Scaffold(
          bottomNavigationBar: Container(
            height: 50,
            child: Row(
              children: const [
                Text(
                  'NOTE:',
                  style: TextStyle(
                      color: AppColors.redcolor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'To upload PDF select folder from dropdown than enter pdf title/name and than click on upload to select and upload PDF',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
          body: _.isLoading
              ? Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Center(
                      child: LoadingAnimationWidget.inkDrop(
                        color: AppColors.bluecolor,
                        size: 50,
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    ProfileScreen(),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Text(
                            'Upload Pdf',
                            maxLines: 1,
                            style: TextStyle(
                                color: AppColors.redcolor,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: AppColors.redcolor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Add Pdf',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CircularButtons(
                      backgroundColor: AppColors.redcolor,
                      borderColor: AppColors.redcolor,
                      text: "Upload",
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.2,
                      onPressed: () async {
                        _.getFile();
                      },
                      textColor: Colors.white,
                      textStyle: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: CommonDropDownField(
                        placeholder: "Role",
                        controller: _.selecttilte,
                        values: _.titlelist,
                        checkedvalue: _.selecttilte,
                        screenController: _,
                      ),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      child: CommonTextFormField1(
                          _.pdftilte,
                          'Enter PDF Title',
                          'PDF Title',
                          false,
                          TextInputType.name,
                          (value) {},
                          1),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
