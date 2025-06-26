import 'dart:math';

import 'package:aadarsh_pvt_ltd/ui/screens/home/controller/home_conroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../helper/routes/routes_names.dart';
import '../../../themes/app_color.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put<HomeController>(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('HR Admin Dashboard',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        actions: [
          _buildNotificationBadge(context),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildWelcomeHeader(),
            SizedBox(height: 20),
            _buildSummaryCards(),
            SizedBox(height: 20),
            _buildActivityHeader(),
            SizedBox(height: 12),
            Expanded(child: _buildRecentActivity()),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationBadge(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: Icon(Icons.notifications, color: Colors.white),
          onPressed: () => _showNotificationPanel(context),
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Obx(() => Text(
                  controller.totalNotify.value.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ),
        ),
      ],
    );
  }

  void _showNotificationPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 5,
            )
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      controller.navigateTo(RoutesNames.notificationDataScreen);
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() => ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(16),
                    itemCount: min(5, controller.notificationsList.length),
                    separatorBuilder: (context, index) => Divider(height: 16),
                    itemBuilder: (context, index) {
                      final notification = controller.notificationsList[index];
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
                          notification.subject ?? "",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          notification.dueDate ?? "",
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: notification.status == "1"
                            ? Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              )
                            : null,
                        onTap: () => controller.navigateRequestDetails(index),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.secondaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.work_outline, color: Colors.white, size: 28),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Obx(() => Text(
                      '${controller.pendingRequests.length} pending requests need your attention',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [
        Expanded(
          child: _buildStatusCard(
            'Pending Request',
            controller.pendingRequests.length,
            Color(0xFFFFA000),
            isHighlighted: true,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatusCard(
            'Complete Request',
            controller.completedRequests.length,
            Color(0xFF4CAF50),
            isHighlighted: true,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: _buildStatusCard(
            'Cancel',
            controller.rejectedRequests.length,
            Color(0xFFF44336),
            isHighlighted: false,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard(String title, int count, Color color,
      {bool isHighlighted = true}) {
    return GestureDetector(
      onTap: () {
        if (title == 'Pending Request') {
          controller.navigateTo(RoutesNames.requestPendingScreen);
        } else if (title == 'Complete Request') {
          controller.navigateTo(RoutesNames.completeRequestScreen);
        } else {
          controller.navigateTo(RoutesNames.rejectRequestScreen);
        }
      },
      child: Card(
        elevation: isHighlighted ? 6 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isHighlighted
              ? BorderSide(color: color.withOpacity(0.3), width: 2)
              : BorderSide.none,
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isHighlighted ? color.withOpacity(0.05) : Colors.white,
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  title == 'Pending Request'
                      ? Icons.pending_actions
                      : title == 'Complete Request'
                          ? Icons.check_circle
                          : Icons.cancel,
                  color: color,
                  size: 24,
                ),
              ),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 4),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Request',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryColor,
          ),
        ),
        TextButton(
          onPressed: () =>
              controller.navigateTo(RoutesNames.notificationDataScreen),
          child: Text(
            'View All',
            style: TextStyle(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Obx(() {
      if (controller.pendingRequests.isEmpty &&
          controller.completedRequests.isEmpty &&
          controller.rejectedRequests.isEmpty) {
        return _buildEmptyState();
      }

      return ListView(
        children: [
          if (controller.pendingRequests.isNotEmpty) ...[
            _buildSectionHeader('Pending Requests'),
            ...controller.pendingRequests
                .take(2)
                .map((request) => _buildActivityItem(request, isPending: true)),
          ],
          if (controller.completedRequests.isNotEmpty) ...[
            _buildSectionHeader('Approved Requests'),
            ...controller.completedRequests.take(2).map(
                (request) => _buildActivityItem(request, isCompleted: true)),
          ],
          if (controller.rejectedRequests.isNotEmpty) ...[
            _buildSectionHeader('Cancel Requests'),
            ...controller.rejectedRequests.take(2).map(
                (request) => _buildActivityItem(request, isRejected: true)),
          ],
        ],
      );
    });
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildActivityItem(
    Map<String, dynamic> request, {
    bool isPending = false,
    bool isCompleted = false,
    bool isRejected = false,
  }) {
    Color statusColor = isPending
        ? Color(0xFFFFA000)
        : isCompleted
            ? Color(0xFF4CAF50)
            : Color(0xFFF44336);
    IconData statusIcon = isPending
        ? Icons.pending
        : isCompleted
            ? Icons.check_circle
            : Icons.cancel;

    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => controller.navigateTo(
          RoutesNames.requestDetailsScreen,
          arguments: request,
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(statusIcon, color: statusColor, size: 24),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Subject: ${request['subject']}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.arrow_forward, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Text(
                          '${request['requestDepartment']} → ${request['receiveDepartment']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    request['status'],
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    request['date'],
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 60,
            color: Colors.grey[300],
          ),
          SizedBox(height: 16),
          Text(
            'No activities yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[500],
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'All your request activities will appear here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
