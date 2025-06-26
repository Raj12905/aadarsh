import 'package:base_module/base/base_controller.dart';
import 'package:get/get.dart';
class CompleteRequestController extends BaseController{
  final RxList<Map<String, dynamic>> completedRequests = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadSampleData();
  }

  void _loadSampleData() {
    // Sample data
    completedRequests.addAll([
      {
        'productId': 'PRD-2023-003',
        'title': 'Projector',
        'subject': 'AV Equipment',
        'requestDepartment': 'Training',
        'receiveDepartment': 'IT',
        'requestDate': '2023-05-20',
        'dueDate': '2023-06-01',
        'completionDate': '2023-05-28',
        'status': 'Approved',
        'details': 'For training room setup'
      }
    ]);
  }
}