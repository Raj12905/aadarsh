
import 'package:get/get.dart';
import '../app_models/approval_response.dart';
import '../app_models/user_login_model_response.dart';
import 'api_service.dart';
import 'base_repository.dart';

class AuthRepository extends BaseRepository {
  final ApiService _apiService = Get.put(ApiService());

  Future<UserLoginModelResponse> userLogin(
      Map<String, dynamic> data, String userToken) async {
    var userLoginResponse = await _apiService.usersLogin(data, userToken);
    return handleResponse(
      userLoginResponse,
      (json) {
        return UserLoginModelResponse.fromJson(json);
      },
    );
  }
  Future<ApprovalResponse> requestForApproval(String userToken) async {
    var response = await _apiService.requestForApproval(userToken);
    return handleResponse(
      response,
      (json) {
        ApprovalResponse approvalResponse = ApprovalResponse.fromJson(json);
        return approvalResponse;
      },
    );
  }
}
