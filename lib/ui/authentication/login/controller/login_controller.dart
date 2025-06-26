import 'package:aadarsh_pvt_ltd/helper/routes/routes_names.dart';
import 'package:aadarsh_pvt_ltd/notification_service.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/home/ui/home_Screen.dart';
import 'package:base_module/app_models/user_login_model_response.dart';
import 'package:base_module/base/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  Rx<LoginData> userData = LoginData().obs;
  NotificationService notificationService = NotificationService();
  @override
  void onClose() {
    // TODO: implement onClose
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  @override
  final isLoading = false.obs;

  apiLogin() async {
    isLoading.value = true;
    var fcmToken = await notificationService.getToken();
    var userToken =
        "b8ea06e9cc1ba88d2b500dd12a2512dcd8f5b2a1d60dad7d5193528dc0f8b96f";
    Map<String, dynamic> data = {
      "username": usernameController.text,
      "password": passwordController.text,
      "fcm_token": fcmToken
    };

    var loginResponse = await authRepository.userLogin(data, userToken);
    isLoading.value = false;

    // Debug print to verify the response structure
    print(
        "Login Response: ${loginResponse.toJson()}"); // if .toJson() exists, otherwise print raw response

    if (loginResponse.data != null) {
      await sharedPrefs.setUserId(loginResponse.data!.id.toString());
      await sharedPrefs.setIsLoggedIn(true);
      await sharedPrefs.setUserData(loginResponse.data);
      navigateAndClearStack(RoutesNames.navigationBarScreen);
    } else {
      String errorMsg = loginResponse.msg ?? 'Login failed. Please try again.';
      showToast(errorMsg);
    }
  }
}
