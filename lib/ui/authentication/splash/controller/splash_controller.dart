import 'package:aadarsh_pvt_ltd/helper/routes/routes_names.dart';
import 'package:base_module/base/base_controller.dart';

class SplashController extends BaseController {
  @override
  void onInit() {
    super.onInit();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    var isUserLogin = await sharedPrefs.getIsLoggedIn();
    // var userType = await sharedPrefs.getUserType();
    await Future.delayed(Duration(seconds: 3), () {
      if (isUserLogin == true) {
        navigateAndClearStack(RoutesNames.navigationBarScreen);
      } else {
        navigateAndClearStack(RoutesNames.loginScreen);
      }
    });
  }
}
