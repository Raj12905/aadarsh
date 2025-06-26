import 'package:aadarsh_pvt_ltd/helper/routes/routes_names.dart';
import 'package:base_module/app_models/approval_response.dart';

import 'package:base_module/base/base_controller.dart';
import 'package:get/get.dart';

class NotificationDataController extends BaseController {
  RxList<ApprovalData> notificationsList = <ApprovalData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRequestApproval();
  }

  void fetchRequestApproval() async {
    isLoading.value = true;
    var userToken = await sharedPrefs.getUserData();
    var requestApprovalResponse =
        await authRepository.requestForApproval(userToken.token!);
    if (requestApprovalResponse.code == 200) {
      isLoading.value = false;

      notificationsList.value = requestApprovalResponse.data ?? [];
    }
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
