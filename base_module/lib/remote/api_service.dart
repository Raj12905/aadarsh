import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../helper/config.dart';

class ApiService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = AppConfig.baseUrl;
    super.onInit();
  }

  String _getFormattedUrl(String endpoint) {
    return endpoint;
  }

  Future<Response> usersLogin(Map<String, dynamic> data, String userToken) {
    var url = AppConfig.actionLogin;
    return post(
      url,
      data,
      headers: {
        "Authorization": userToken,
        "Content-Type": "application/json",
      },
    );
  }
  Future<Response> requestForApproval(String userToken) async {
    var url = AppConfig.actionGetRequestForApproval;
    return get(
      url,
      headers: {
        "Authorization": userToken,
        "Content-Type": "application/json",
      },
    );
  }
}

