import 'package:base_module/app_models/approval_response.dart';
import 'package:base_module/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../helper/routes/routes_names.dart';
import '../../../../notification_service.dart';


class HomeController extends BaseController{
  final notification = NotificationService();
  // Request Lists
  final RxList<Map<String, dynamic>> pendingRequests = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> completedRequests = <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> rejectedRequests = <Map<String, dynamic>>[].obs;

  // Notification System
  final RxList<ApprovalData> notifications = <ApprovalData>[].obs;
  final RxList<ApprovalData> notificationsList = <ApprovalData>[].obs;
  RxInt totalNotify = 0.obs;
  final RxInt unreadNotifications = 0.obs;

  final RxString selectedFilter = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    recentRequestNotification();
    notification.requestNotificationPermission();
    notification.listenForMessages();
    _loadInitialData();
  }

  void recentRequestNotification() async {
    isLoading.value = true;
    var userToken = await sharedPrefs.getUserData();
    var requestApprovalResponse = await authRepository.requestForApproval(userToken.token!);
    if (requestApprovalResponse.code == 200) {
      isLoading.value = false;
      totalNotify.value = requestApprovalResponse.count ?? 0;
      notificationsList.value = requestApprovalResponse.data ?? [];
    }
  }




  Future<void> _loadInitialData() async {
    isLoading.value = true;

    // Simulate API calls
    await Future.delayed(Duration(milliseconds: 800));

    // Load sample data
    _loadSampleRequests();
    _loadSampleNotifications();

    isLoading.value = false;
  }

  void _loadSampleRequests() {
    final now = DateTime.now();
    final formatter = DateFormat('MMM dd, yyyy');

    pendingRequests.addAll([
      {
        'id': 'PR-20250411034718',
        'title': 'Material required for nor Production',
        'subject': 'Cooler required for MP Nagar',
        'requestDepartment': 'Hr Admin',
        'receiveDepartment': 'Aadarsh Pvt Ltd',
        'date': formatter.format(now),
        'status': 'Pending',
        'priority': 'High'
      },
      {
        'id': 'PR-${now.millisecondsSinceEpoch.toString().substring(6)}',
        'title': 'Office Chairs',
        'subject': 'Furniture Request',
        'requestDepartment': 'Finance',
        'receiveDepartment': 'Facilities',
        'date': formatter.format(now.subtract(Duration(days: 1))),
        'status': 'Pending',
        'priority': 'Medium'
      }
    ]);

    completedRequests.addAll([
      {
        'id': 'PR-${now.millisecondsSinceEpoch.toString().substring(6)}',
        'title': 'Projector',
        'subject': 'AV Equipment',
        'requestDepartment': 'Training',
        'receiveDepartment': 'IT',
        'date': formatter.format(now.subtract(Duration(days: 3))),
        'status': 'Approved',
        'approvedDate': formatter.format(now.subtract(Duration(days: 2)))
      }
    ]);

    rejectedRequests.addAll([
      {
        'id': 'PR-${now.millisecondsSinceEpoch.toString().substring(6)}',
        'title': 'Desk Setup',
        'subject': 'Furniture Request',
        'requestDepartment': 'Operations',
        'receiveDepartment': 'Facilities',
        'date': formatter.format(now.subtract(Duration(days: 5))),
        'status': 'Rejected',
        'rejectionReason': 'Budget constraints'
      }
    ]);
  }

  void _loadSampleNotifications() async {

    // unreadNotifications.value = notifications.where((n) => !n['isRead']).length;
  }

  // Navigation Methods
  void navigateTo(String routeName, {dynamic arguments}) {
    Get.toNamed(routeName, arguments: arguments);
  }

  /*// Notification Methods
  void markNotificationAsRead(int index) {
    if (index >= 0 && index < notifications.length) {
      notifications[index]['isRead'] = true;
      notifications.refresh();
      unreadNotifications.value = notifications.where((n) => !n['isRead']).length;
    }
  }

  void markAllNotificationsAsRead() {
    for (var notification in notifications) {
      notification['isRead'] = true;
    }
    notifications.refresh();
    unreadNotifications.value = 0;
  }*/

  // Request Approval/Rejection
  void approveRequest(String requestId) {
    final request = pendingRequests.firstWhere(
          (req) => req['id'] == requestId,
      orElse: () => null as Map<String, dynamic>,
    );

    if (request != null) {
      pendingRequests.remove(request);
      request['status'] = 'Approved';
      request['approvedDate'] = DateFormat('MMM dd, yyyy').format(DateTime.now());
      completedRequests.insert(0, request);

     /* // Add notification
      _addNotification(
          'Request Approved',
          '${request['title']} has been approved',
          'approval'
      );*/
    }
  }

  void rejectRequest(String requestId, String reason) {
    final request = pendingRequests.firstWhere(
          (req) => req['id'] == requestId,
      orElse: () => null as Map<String, dynamic>,
    );

    if (request != null) {
      pendingRequests.remove(request);
      request['status'] = 'Rejected';
      request['rejectionReason'] = reason;
      request['rejectedDate'] = DateFormat('MMM dd, yyyy').format(DateTime.now());
      rejectedRequests.insert(0, request);

      // Add notification
      /*_addNotification(
          'Request Rejected',
          '${request['title']} was rejected: $reason',
          'rejection'
      );*/
    }
  }
/*
  void _addNotification(String title, String message, String type) {
    final now = DateTime.now();
    notifications.insert(0, {
      'id': 'NT-${now.millisecondsSinceEpoch}',
      'title': title,
      'message': message,
      'time': DateFormat('h:mm a').format(now),
      'isRead': false,
      'type': type
    });
    unreadNotifications.value++;
  }*/

  // Filtering
  List<Map<String, dynamic>> get filteredPendingRequests {
    if (selectedFilter.value == 'All') return pendingRequests;
    return pendingRequests.where((req) =>
    req['requestDepartment'] == selectedFilter.value
    ).toList();
  }

  List<String> get availableDepartments {
    final departments = <String>{};
    pendingRequests.forEach((req) => departments.add(req['requestDepartment']));
    return ['All', ...departments.toList()];
  }

  // Refresh Data
  Future<void> refreshData() async {
    isLoading.value = true;
    pendingRequests.clear();
    completedRequests.clear();
    rejectedRequests.clear();
    await _loadInitialData();
  }

  void navigateRequestDetails(int index) {
    Map<String, dynamic> requestData = {
      "id": notificationsList[index].id ?? "",
      "request_id": notificationsList[index].requestId ?? "",
      "request_did": notificationsList[index].requestDid ?? "",
      "request_received_did": notificationsList[index].requestReceivedDid ?? "",
      "forward_did": notificationsList[index].forwardDid ?? "",
      "sup_id": notificationsList[index].supId ?? "",
      "leave_status": notificationsList[index].leaveStatus ?? "",
      "material_status": notificationsList[index].materialStatus ?? "",
      "material_issue": notificationsList[index].materialIssue ?? "",
      "request_date_time": notificationsList[index].requestDateTime ?? "",
      "due_date": notificationsList[index].dueDate ?? "",
      "title_id": notificationsList[index].titleId ?? "",
      "subject": notificationsList[index].subject ?? "",
      "remarks_textarea": notificationsList[index].remarksTextarea ?? "",
      "status": notificationsList[index].status ?? "",
      "remarks1": notificationsList[index].remarks1 ?? "",
      "remarks2": notificationsList[index].remarks2 ?? "",
      "remarks3": notificationsList[index].remarks3 ?? "",
      "remarks4": notificationsList[index].remarks4 ?? "",
      "remarks5": notificationsList[index].remarks5 ?? "",
      "attachment1": notificationsList[index].attachment1 ?? "",
      "attachment2": notificationsList[index].attachment2 ?? "",
      "attachment3": notificationsList[index].attachment3 ?? "",
      "attachment4": notificationsList[index].attachment4 ?? "",
      "attachment5": notificationsList[index].attachment5 ?? "",
      "created_at": notificationsList[index].createdAt ?? "",
      "updated_at": notificationsList[index].updatedAt ?? "",
    };
    navigateTo(RoutesNames.requestDetailsScreen, arguments: requestData);
  }
}