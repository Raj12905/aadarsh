import 'package:aadarsh_pvt_ltd/ui/screens/request_details/cotroller/request_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../themes/app_color.dart';
import '../../../widgets/input_fields.dart';

class RequestDetailsScreen extends StatelessWidget {
  RequestDetailsScreen({super.key});
  final controller = Get.find<RequestDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Request Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        final request = controller.request;
        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card with essential info
              _buildHeaderCard(),
              SizedBox(height: 20),

              // Main Details Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Request Information'),
                      SizedBox(height: 12),
                      _buildDetailRow('Request ID', request['id'] ?? '--'),
                      _buildDivider(),
                      _buildDetailRow('Title', _getTitle(request['title_id'])),
                      _buildDivider(),
                      _buildDetailRow('Subject', convertHtmlToPlainText(request['subject'] ?? '--')),
                      _buildDivider(),
                      _buildDetailRow('Request Date',
                          _formatDateTime(request['request_date_time'])),
                      _buildDivider(),
                      _buildDetailRow(
                          'Due Date', _formatDate(request['due_date'])),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Departments Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Departments'),
                      SizedBox(height: 12),
                      _buildDetailRow(
                          'From', _getDepartmentName(request['request_did'])),
                      _buildDivider(),
                      _buildDetailRow('To',
                          _getDepartmentName(request['request_received_did'])),
                      if (request['forward_did'] != "0") ...[
                        _buildDivider(),
                        _buildDetailRow('Forwarded To',
                            _getDepartmentName(request['forward_did'])),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Status Card
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Status Information'),
                      SizedBox(height: 12),
                      _buildStatusChip(_getStatusText(request['status']),
                          _getStatusColor(request['status'])),
                      SizedBox(height: 8),
                      _buildDetailRow('Material Status',
                          _getMaterialStatusText(request['material_status'])),
                      _buildDivider(),
                      _buildDetailRow('Material Issue',
                          request['material_issue'] == "1" ? 'Yes' : 'No'),
                      if (request['leave_status'] != "0") ...[
                        _buildDivider(),
                        _buildDetailRow('Leave Status',
                            _getLeaveStatusText(request['leave_status'])),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Remarks Card
              if (request['remarks_textarea']?.isNotEmpty == true ||
                  _hasRemarks())
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Remarks'),
                          SizedBox(height: 12),
                          if (request['remarks_textarea']?.isNotEmpty == true)
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Text(
                                convertHtmlToPlainText(request['remarks_textarea'] ?? ""),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          if (_hasRemarks())
                            ..._buildAdditionalRemarks(),
                        ],
                      ),
                    ),
                  ),
                ),

              // Attachments Card
              if (_hasAttachments()) ...[
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle('Attachments'),
                          SizedBox(height: 12),
                          ..._buildAttachmentButtons(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.blue[50],
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.description, color: Colors.blue[800]),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Request #${controller.request['id']}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "${controller.request['subject']}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.blue[800],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey[200],
    );
  }

  Widget _buildStatusChip(String text, Color color) {
    return Chip(
      label: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  List<Widget> _buildAttachmentButtons() {
    List<Widget> buttons = [];
    for (int i = 1; i <= 5; i++) {
      final attachment = controller.request['attachment$i'];
      if (attachment != null) {
        buttons.add(
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: OutlinedButton.icon(
              icon: Icon(Icons.attach_file, size: 18,color: Colors.white,),
              label: Text('Attachment $i',style: TextStyle(color: Colors.white),),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                side: BorderSide(color: Colors.blue[200]!),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onPressed: () => controller.viewAttachment(attachment),
            ),
          ),
        );
      }
    }
    return buttons;
  }

  List<Widget> _buildAdditionalRemarks() {
    List<Widget> remarks = [];
    for (int i = 1; i <= 5; i++) {
      final remark = controller.request['remarks$i'];
      if (remark != null) {
        remarks.add(
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              '• $remark',
              style: TextStyle(fontSize: 14),
            ),
          ),
        );
      }
    }
    return remarks;
  }

  bool _hasAttachments() {
    return controller.request['attachment1'] != null ||
        controller.request['attachment2'] != null ||
        controller.request['attachment3'] != null ||
        controller.request['attachment4'] != null ||
        controller.request['attachment5'] != null;
  }

  bool _hasRemarks() {
    return controller.request['remarks1'] != null ||
        controller.request['remarks2'] != null ||
        controller.request['remarks3'] != null ||
        controller.request['remarks4'] != null ||
        controller.request['remarks5'] != null;
  }

  String _formatDateTime(String? dateTime) {
    if (dateTime == null) return '--';
    try {
      final parsed = DateTime.parse(dateTime);
      return DateFormat('MMM dd, yyyy - hh:mm a').format(parsed);
    } catch (e) {
      return dateTime;
    }
  }

  String _formatDate(String? date) {
    if (date == null) return '--';
    try {
      final parsed = DateTime.parse(date);
      return DateFormat('MMM dd, yyyy').format(parsed);
    } catch (e) {
      return date;
    }
  }

  String _getTitle(String titleId) {
    // You would replace this with your actual title mapping logic
    switch (titleId) {
      case '1':
        return 'Material Request';
      case '2':
        return 'Leave Request';
      case '3':
        return 'Maintenance Request';
      default:
        return 'General Request';
    }
  }

  String _getDepartmentName(String did) {
    // You would replace this with your actual department mapping logic
    switch (did) {
      case '1':
        return 'Administration';
      case '2':
        return 'Production';
      case '3':
        return 'Quality Control';
      case '4':
        return 'Logistics';
      case '5':
        return 'HR';
      case '6':
        return 'Finance';
      case '7':
        return 'IT';
      case '8':
        return 'Engineering';
      case '9':
        return 'Maintenance';
      default:
        return 'Unknown Department';
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case '0':
        return 'Pending';
      case '1':
        return 'Approved';
      case '2':
        return 'Rejected';
      case '3':
        return 'In Progress';
      case '4':
        return 'Completed';
      default:
        return 'Unknown Status';
    }
  }

  String _getMaterialStatusText(String status) {
    switch (status) {
      case '0':
        return 'Not Received';
      case '1':
        return 'Received';
      case '2':
        return 'Partially Received';
      case '3':
        return 'In Transit';
      default:
        return 'Unknown';
    }
  }

  String _getLeaveStatusText(String status) {
    switch (status) {
      case '0':
        return 'Not Applied';
      case '1':
        return 'Approved';
      case '2':
        return 'Rejected';
      case '3':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case '0':
        return Colors.orange; // Pending
      case '1':
        return Colors.green; // Approved
      case '2':
        return Colors.red; // Rejected
      case '3':
        return Colors.blue; // In Progress
      case '4':
        return Colors.purple; // Completed
      default:
        return Colors.grey;
    }
  }
}
