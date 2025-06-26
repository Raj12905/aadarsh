import 'package:base_module/base/base_controller.dart';
import 'package:get/get.dart';

class RejectRequestController extends BaseController{
  final RxList<Map<String, dynamic>> rejectedRequests = <Map<String, dynamic>>[].obs;
  final RxList<String> notifications = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadSampleData();
  }

  void _loadSampleData() {
    // Sample data
    rejectedRequests.addAll([
      {
        'productId': 'PRD-2023-004',
        'title': 'Desk Setup',
        'subject': 'Furniture Request',
        'requestDepartment': 'Operations',
        'receiveDepartment': 'Facilities',
        'requestDate': '2023-05-15',
        'dueDate': '2023-06-15',
        'rejectionDate': '2023-05-18',
        'status': 'Rejected',
        'reason': 'Budget constraints',
        'details': 'New desks for expansion'
      }
    ]);
  }

}