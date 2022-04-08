// ignore_for_file: prefer_is_empty

import 'package:care_navigation_admin_panel/controller/userlist/userlist_controller.dart';
import 'package:care_navigation_admin_panel/view/profile/admin_profile.dart';
import 'package:care_navigation_admin_panel/widgets/app_button.dart';
import 'package:care_navigation_admin_panel/widgets/app_colors.dart';
import 'package:care_navigation_admin_panel/widgets/app_textfield.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<UserListController>(
      init: UserListController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: AppColors.backgroundcolor,
          body: ListView(
            children: [
              ProfileScreen(),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      'Users List',
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
              ).marginSymmetric(horizontal: 30),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: CommonTextFormField(_.search, 'Search Users',
                          'Search', false, TextInputType.name, 1, (e) {
                        _.searchFunction(e);
                      }, () {}),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
              ),
              _.isLoading
                  ? Center(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: LoadingAnimationWidget.inkDrop(
                          color: AppColors.bluecolor,
                          size: 50,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: DataTable2(
                            dataTextStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            sortAscending: true,
                            dividerThickness: 2,
                            dataRowHeight: 60,
                            dataRowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.white),
                            columns: const <DataColumn>[
                              DataColumn2(
                                label: Text('Name',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.redcolor)),
                              ),
                              DataColumn2(
                                label: Center(
                                    child: Text(
                                  'Email',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.redcolor),
                                )),
                              ),
                              DataColumn2(
                                label: Center(
                                    child: Text(
                                  'Phone Number',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.redcolor),
                                )),
                              ),
                              DataColumn2(
                                label: Center(
                                    child: Text(
                                  'Actions',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.redcolor),
                                )),
                              ),
                            ],
                            rows: List.generate(
                                _.searchlist.length == 0
                                    ? _.userlist.length
                                    : _.searchlist.length, (index) {
                              return DataRow(cells: [
                                DataCell(
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      _.searchlist.length == 0
                                          ? Text(
                                              '${_.userlist[index]['username']}',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            )
                                          : Text(
                                              '${_.searchlist[index]['username']} ',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black),
                                            )
                                    ],
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: _.searchlist.length == 0
                                        ? Text(
                                            '${_.userlist[index]['email']}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          )
                                        : Text(
                                            '${_.searchlist[index]['email']}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                  ),
                                ),
                                DataCell(
                                  Center(
                                    child: _.searchlist.length == 0
                                        ? Text(
                                            '${_.userlist[index]['phone']}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          )
                                        : Text(
                                            '${_.searchlist[index]['phone']}',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                  ),
                                ),
                                DataCell(
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        height: 40,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                            color: Color(0xffE3EFFF),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: IconButton(
                                          icon: const Icon(
                                            FontAwesomeIcons.trashAlt,
                                            color: AppColors.redcolor,
                                          ),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(20.0),
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
                                                                  'Do You Want To delete this user',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          25,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
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
                                                                      AppColors
                                                                          .redcolor,
                                                                  borderColor:
                                                                      AppColors
                                                                          .redcolor,
                                                                  text: 'Yes',
                                                                  height: 50,
                                                                  width: width *
                                                                      0.1,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  textStyle:
                                                                      const TextStyle(),
                                                                  onPressed:
                                                                      () {
                                                                    _.searchlist.length ==
                                                                            0
                                                                        ? _.deleteuser(_.userlist[index]
                                                                            [
                                                                            'id'])
                                                                        : _.deleteuser(_.searchlist[index]
                                                                            [
                                                                            'id']);

                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                ),
                                                                CircularButtons(
                                                                  backgroundColor:
                                                                      AppColors
                                                                          .greycolor,
                                                                  borderColor:
                                                                      AppColors
                                                                          .greycolor,
                                                                  text: 'No',
                                                                  height: 50,
                                                                  width: width *
                                                                      0.1,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
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
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]);
                            }),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }

  showAlertBox(UserListController _, context, firstname, email, docid) {
    _.firstname.text = firstname;
    _.email.text = email;
    _.update();
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          "Update Data",
          style: TextStyle(),
        ),
        content: SizedBox(
          height: 250,
          width: Get.width / 2.5,
          child: Column(
            children: [
              SizedBox(
                width: Get.width / 2.6,
                child: CommonTextFormField(_.firstname, 'First Name',
                    'First Name', false, TextInputType.name, 1, (e) {}, () {}),
              ),
              const SizedBox(
                height: 20.0,
              ),
              SizedBox(
                width: Get.width / 2.6,
                child: CommonTextFormField(_.email, 'Last Name', 'Last Name',
                    false, TextInputType.name, 1, (e) {}, () {}),
              ),
              const Spacer(),
              CircularButtons(
                text: "Update Data",
                width: 150,
                height: 40,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                onPressed: () {
                  Get.back();
                  _.updateuser(docid);
                },
                backgroundColor: AppColors.bluecolor,
                textColor: Colors.white,
                borderColor: AppColors.bluecolor,
              ),
            ],
          ),
          // child: ,
        ),
      ),
    );
  }
}
