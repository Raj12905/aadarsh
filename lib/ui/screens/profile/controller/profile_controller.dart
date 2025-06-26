import 'package:base_module/app_models/user_login_model_response.dart';
import 'package:base_module/base/base_controller.dart';
import 'package:get/get.dart';

class ProfileController extends BaseController {
  Rx<LoginData> userData = LoginData().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getUserLoginData();
    super.onInit();
  }

  Future getUserLoginData() async {
    userData.value = await sharedPrefs.getUserData();
  }
}
