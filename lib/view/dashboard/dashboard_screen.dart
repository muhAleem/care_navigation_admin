import 'package:care_navigation_admin_panel/controller/dashboard/dashboard_controller.dart';
import 'package:care_navigation_admin_panel/view/profile/admin_profile.dart';
import 'package:care_navigation_admin_panel/widgets/app_colors.dart';
import 'package:care_navigation_admin_panel/widgets/card_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return GetBuilder<DashBoardController>(
        init: DashBoardController(),
        builder: (_) {
          return Scaffold(
            backgroundColor: AppColors.backgroundcolor,
            body: _.isLoading
                ? Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: LoadingAnimationWidget.threeRotatingBalls(
                          color: AppColors.redcolor,
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
                              'DashBoard',
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
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CardTile(
                              cardTitle: 'Users',
                              icon: Icons.account_balance_outlined,
                              iconBgColor: Colors.indigo,
                              mainText: '${_.usersList.length}',
                              subText: 'Total Users',
                            ),
                            // statsContainer(
                            //     context, 'Total Nurses Accounts', '${_.nurseslist.length}'),
                            CardTile(
                              cardTitle: 'Admin',
                              icon: Icons.account_balance_wallet_outlined,
                              iconBgColor: Colors.red,
                              mainText: '${_.adminList.length}',
                              subText: 'Total Admin',
                            ),
                            CardTile(
                              cardTitle: 'Notices',
                              icon: Icons.info_outline,
                              iconBgColor: Colors.blueGrey,
                              mainText: '${_.noticeList.length}',
                              subText: 'Total Notices',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CardTile(
                              cardTitle: 'Announcement',
                              icon: Icons.account_balance_outlined,
                              iconBgColor: Colors.orangeAccent,
                              mainText: '${_.announcementList.length}',
                              subText: 'Total Announcements',
                            ),
                            CardTile(
                              cardTitle: 'Policy and Procedure',
                              icon: Icons.account_balance_outlined,
                              iconBgColor: Colors.purple,
                              mainText: '${_.policyList.length}',
                              subText: 'Total Polices',
                            ),
                            CardTile(
                              cardTitle: 'Assessment',
                              icon: Icons.info_outline,
                              iconBgColor: Colors.redAccent,
                              mainText: '${_.assessmentList.length}',
                              subText: 'Total Assessments',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        });
  }

  Widget statsContainer(BuildContext context, String title, String stats) {
    return Container(
      width: Get.width / 6,
      height: Get.height / 5,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              stats,
              style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
