import 'package:aadarsh_pvt_ltd/ui/screens/reject_request/controller/reject_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../helper/routes/routes_names.dart';
import '../../../themes/app_color.dart';
import '../../home/controller/home_conroller.dart';

class RejectRequestScreen extends StatelessWidget {
  RejectRequestScreen({super.key});
  final controller =
      Get.put<RejectRequestController>(RejectRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Rejected Requests',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFFF44336),
      ),
      body: Obx(() => ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: controller.rejectedRequests.length,
            itemBuilder: (context, index) {
              final request = controller.rejectedRequests[index];
              return _buildRequestCard(request);
            },
          )),
    );
  }

  Widget _buildRequestCard(Map<String, dynamic> request) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => controller.navigateTo(RoutesNames.requestDetailsScreen,
            arguments: request),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    request['productId'],
                    style: TextStyle(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Chip(
                    label: Text('Rejected'),
                    backgroundColor: Colors.red.withOpacity(0.2),
                    labelStyle: TextStyle(color: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                request['title'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Subject: ${request['subject']}',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(
                    '${request['requestDepartment']} → ${request['receiveDepartment']}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Spacer(),
                  Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(
                    'Rejected: ${request['rejectionDate']}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
