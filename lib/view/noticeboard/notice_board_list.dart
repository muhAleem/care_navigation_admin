import 'package:care_navigation_admin_panel/controller/noticeboard/notice_board_list_controller.dart';
import 'package:care_navigation_admin_panel/view/profile/admin_profile.dart';
import 'package:care_navigation_admin_panel/widgets/app_button.dart';
import 'package:care_navigation_admin_panel/widgets/app_colors.dart';
import 'package:care_navigation_admin_panel/widgets/app_textfield.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class NoticeBoardData extends StatelessWidget {
  const NoticeBoardData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<NoticeBoardListController>(
      init: NoticeBoardListController(),
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
                      'Notice List',
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
                      child: CommonTextFormField(_.search, 'Search Notice',
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
                        child: LoadingAnimationWidget.threeRotatingBalls(
                          color: AppColors.redcolor,
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
                            horizontalMargin: 10,
                            dataTextStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            sortAscending: true,
                            dividerThickness: 2,
                            dataRowHeight: 60,
                            // dataRowColor: MaterialStateColor.resolveWith(
                            //     (states) => Colors.grey),
                            columns: const <DataColumn>[
                              DataColumn2(
                                label: Text('Title',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.redcolor)),
                              ),
                              DataColumn2(
                                label: Align(
                                    alignment: Alignment.center,
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
                                _.searchlist.isEmpty
                                    ? _.noticelist.length
                                    : _.searchlist.length, (index) {
                              return DataRow(cells: [
                                DataCell(
                                  _.searchlist.isEmpty
                                      ? Text(
                                          '${_.noticelist[index]['name']}',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),

                                          //style: titleStyle,
                                        )
                                      : Text(
                                          '${_.searchlist[index]['name']} ',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),

                                          //style: titleStyle,
                                        ),
                                ),
                                DataCell(Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        icon: const Icon(
                                          FontAwesomeIcons.trashAlt,
                                          color: AppColors.redcolor,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(20.0),
                                                    ),
                                                  ),
                                                  backgroundColor: Colors.white,
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
                                                              'Are You sure to delete this notice?',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 25,
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
                                                              width:
                                                                  width * 0.1,
                                                              textColor:
                                                                  Colors.white,
                                                              textStyle:
                                                                  const TextStyle(),
                                                              onPressed: () {
                                                                _.searchlist
                                                                        .isEmpty
                                                                    ? _.deletenotice(
                                                                        _.noticelist[index]
                                                                            [
                                                                            'id'])
                                                                    : _.deletenotice(
                                                                        _.searchlist[index]
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
                                                              width:
                                                                  width * 0.1,
                                                              textColor:
                                                                  Colors.white,
                                                              textStyle:
                                                                  const TextStyle(),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                            },
                                          );
                                        }),
                                  ],
                                ))
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
}
