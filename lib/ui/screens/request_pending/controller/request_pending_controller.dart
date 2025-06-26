import 'package:base_module/base/base_controller.dart';
import 'package:get/get.dart';

class RequestPendingController extends BaseController {
  final RxList<Map<String, dynamic>> pendingRequests = <Map<String, dynamic>>[]
      .obs;

  @override
  void onInit() {
    super.onInit();
    _loadSampleData();
  }

  void _loadSampleData() {
    // Sample data
    pendingRequests.addAll([
      {
        'productId': 'PRD-2023-001',
        'title': 'Laptop Replacement',
        'subject': 'IT Equipment Request',
        'requestDepartment': 'Marketing',
        'receiveDepartment': 'IT',
        'requestDate': '2023-06-15',
        'dueDate': '2023-06-30',
        'status': 'Pending',
        'details': 'Need replacement for damaged laptop'
      },
      {
        'productId': 'PRD-2023-002',
        'title': 'Office Chairs',
        'subject': 'Furniture Request',
        'requestDepartment': 'Finance',
        'receiveDepartment': 'Facilities',
        'requestDate': '2023-06-10',
        'dueDate': '2023-07-10',
        'status': 'Pending',
        'details': 'New chairs for accounting department'
      }
    ]);
  }
}