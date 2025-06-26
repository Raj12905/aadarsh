import 'dart:math';
import 'package:aadarsh_pvt_ltd/helper/routes/routes_names.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/notification_data/controller/notification_data_controller.dart';
import 'package:flutter/material.dart';
import '../../../themes/app_color.dart';
import 'package:get/get.dart';

class NotificationDataScreen extends StatelessWidget {
  NotificationDataScreen({super.key});
  final controller = Get.find<NotificationDataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.fetchRequestApproval,
          )
        ],
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }
          if (controller.notificationsList.isEmpty) {
            return Center(child: Text('No notifications found.'));
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  notifyList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget notifyList() {
    print("kdfgbkjbdfgs  ${controller.notificationsList.length}");
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.notificationsList.length,
      separatorBuilder: (context, index) => Divider(height: 16),
      itemBuilder: (context, index) {
        final notifyList = controller.notificationsList[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_active,
              color: AppColors.secondaryColor,
            ),
          ),
          title: Text(
            notifyList.subject ?? "",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            notifyList.createdAt ?? "",
            style: TextStyle(fontSize: 12),
          ),
          onTap: () => controller.navigateRequestDetails(index),
        );
      },
    );
  }
}
