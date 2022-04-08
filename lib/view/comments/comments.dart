import 'package:cached_network_image/cached_network_image.dart';
import 'package:care_navigation_admin_panel/controller/comments/comments_controller.dart';
import 'package:care_navigation_admin_panel/view/profile/admin_profile.dart';
import 'package:care_navigation_admin_panel/widgets/app_colors.dart';
import 'package:care_navigation_admin_panel/widgets/app_textfield.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Comments extends StatelessWidget {
  const Comments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<CommentsController>(
      init: CommentsController(),
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
                      'Comments',
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
                  : Container(
                      height: Get.height * 0.8,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      margin: const EdgeInsets.only(bottom: 10),
                      color: Colors.white,
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(
                          color: Colors.grey,
                        ).marginSymmetric(horizontal: 30),
                        itemCount: _.commentlist.length,
                        itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Row(
                                children: <Widget>[
                                  Text(
                                    '${_.commentlist[index]['username']}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('${_.commentlist[index]['email']}',
                                      style: TextStyle(
                                          color: Colors.grey[500],
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              subtitle: Text(
                                '${_.commentlist[index]['comment']}',
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    _.deletecomment(
                                        (_.commentlist[index]['id']));
                                  }),
                            )),
                      ))
            ],
          ),
        );
      },
    );
  }
}
