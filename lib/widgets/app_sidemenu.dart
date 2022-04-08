import 'package:care_navigation_admin_panel/controller/sidemenu/sidemenu_controlller.dart';
import 'package:care_navigation_admin_panel/view/adminlist/adminlist.dart';
import 'package:care_navigation_admin_panel/view/announcement/announcement_list.dart';
import 'package:care_navigation_admin_panel/view/announcement/announcement_screen.dart';
import 'package:care_navigation_admin_panel/view/assessment/assessment_list.dart';
import 'package:care_navigation_admin_panel/view/assessment/assessment_screen.dart';
import 'package:care_navigation_admin_panel/view/comments/comments.dart';
import 'package:care_navigation_admin_panel/view/create_folder.dart';
import 'package:care_navigation_admin_panel/view/dashboard/dashboard_screen.dart';
import 'package:care_navigation_admin_panel/view/folder/add_pdf.dart';
import 'package:care_navigation_admin_panel/view/folder/folder_list.dart';
import 'package:care_navigation_admin_panel/view/noticeboard/notice_board_list.dart';
import 'package:care_navigation_admin_panel/view/noticeboard/notice_board_screen.dart';
import 'package:care_navigation_admin_panel/view/policy/policy_list.dart';
import 'package:care_navigation_admin_panel/view/policy/policy_screen.dart';
import 'package:care_navigation_admin_panel/view/updateaccout/update_account.dart';
import 'package:care_navigation_admin_panel/view/userlist/userlist.dart';
import 'package:care_navigation_admin_panel/widgets/app_colors.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return GetBuilder<SidebarController>(
      init: SidebarController(),
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(24.0),
                      bottomRight: Radius.circular(24.0),
                      bottomLeft: Radius.circular(24.0),
                      topLeft: Radius.circular(24.0)),
                ),
                child: SideMenu(
                    controller: _.page,
                    style: SideMenuStyle(
                        openSideMenuWidth:
                            MediaQuery.of(context).size.width * 0.17,
                        unselectedIconColor: AppColors.redcolor,
                        compactSideMenuWidth: width,
                        displayMode: SideMenuDisplayMode.open,
                        hoverColor: const Color(0xffC2AA52),
                        selectedColor: Colors.grey,
                        selectedTitleTextStyle:
                            const TextStyle(color: Colors.black, fontSize: 15),
                        unselectedTitleTextStyle: const TextStyle(
                            fontSize: 15, color: AppColors.redcolor),
                        selectedIconColor: Colors.black,
                        backgroundColor: Colors.white,
                        iconSize: 15),
                    title: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Image.asset(
                            'assets/images/app_logo.png',
                            height: 100,
                            width: 250,
                          ),
                        ),
                      ],
                    ),
                    items: [
                      SideMenuItem(
                          priority: 0,
                          title: 'Dashboard',
                          onTap: () {
                            _.page.jumpToPage(0);
                          },
                          icon: Icons.dashboard),
                      SideMenuItem(
                          priority: 1,
                          title: 'Users',
                          onTap: () {
                            _.page.jumpToPage(1);
                          },
                          icon: Icons.people),
                      SideMenuItem(
                          priority: 2,
                          title: 'Admins',
                          onTap: () {
                            _.page.jumpToPage(2);
                          },
                          icon: Icons.account_circle),
                      SideMenuItem(
                          priority: 3,
                          title: 'Update Profile',
                          onTap: () {
                            _.page.jumpToPage(3);
                          },
                          icon: Icons.update),
                      SideMenuItem(
                          priority: 4,
                          title: 'Add Notice',
                          onTap: () {
                            _.page.jumpToPage(4);
                          },
                          icon: Icons.details),
                      SideMenuItem(
                        priority: 5,
                        title: 'Notice Details',
                        onTap: () {
                          _.page.jumpToPage(5);
                        },
                        icon: FontAwesomeIcons.list,
                      ),
                      SideMenuItem(
                        priority: 6,
                        title: 'Add Announcement',
                        onTap: () {
                          _.page.jumpToPage(6);
                        },
                        icon: Icons.announcement,
                      ),
                      SideMenuItem(
                        priority: 7,
                        title: 'Announcement Details',
                        onTap: () {
                          _.page.jumpToPage(7);
                        },
                        icon: FontAwesomeIcons.list,
                      ),
                      SideMenuItem(
                          priority: 8,
                          title: 'Add Policy ',
                          onTap: () {
                            _.page.jumpToPage(8);
                          },
                          icon: Icons.policy),
                      SideMenuItem(
                        priority: 9,
                        title: 'Policy List',
                        onTap: () {
                          _.page.jumpToPage(9);
                        },
                        icon: FontAwesomeIcons.listUl,
                      ),
                      SideMenuItem(
                        priority: 10,
                        title: 'Add Assessment',
                        onTap: () {
                          _.page.jumpToPage(10);
                        },
                        icon: Icons.assessment,
                      ),
                      SideMenuItem(
                        priority: 11,
                        title: 'Assessment List',
                        onTap: () {
                          _.page.jumpToPage(11);
                        },
                        icon: FontAwesomeIcons.list,
                      ),
                      SideMenuItem(
                          priority: 12,
                          title: 'Create Folder',
                          onTap: () {
                            _.page.jumpToPage(12);
                          },
                          icon: FontAwesomeIcons.folderPlus),
                      SideMenuItem(
                        priority: 13,
                        title: 'Folder List',
                        onTap: () {
                          _.page.jumpToPage(13);
                        },
                        icon: FontAwesomeIcons.folder,
                      ),
                      SideMenuItem(
                          priority: 14,
                          title: 'Upload pdf',
                          onTap: () {
                            _.page.jumpToPage(14);
                          },
                          icon: FontAwesomeIcons.filePdf),
                      SideMenuItem(
                        priority: 15,
                        title: 'Comments',
                        onTap: () {
                          _.page.jumpToPage(15);
                        },
                        icon: FontAwesomeIcons.comment,
                      ),
                    ]),
              ),
              Expanded(
                child: PageView(
                  pageSnapping: false,
                  reverse: false,
                  physics: const NeverScrollableScrollPhysics(),
                  allowImplicitScrolling: false,
                  controller: _.page,
                  children: const [
                    DashBoard(),
                    UserList(),
                    AdminData(),
                    UpdateAccount(),
                    NoticeBoard(),
                    NoticeBoardData(),
                    AnnouncementScreen(),
                    AnnouncementData(),
                    PolicyScreen(),
                    PolicyData(),
                    AssessmentDataScreen(),
                    AssessmentData(),
                    CreateFolder(),
                    FolderList(),
                    AddPdf(),
                    Comments()
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
