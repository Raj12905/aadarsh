import 'package:get/get.dart';

import 'navigation__service_impl.dart';

class NavigationService implements INavigationService {
  @override
  void navigateTo(String routeName, {dynamic arguments}) {
    Get.toNamed(routeName, arguments: arguments);
  }

  @override
  void backToPreviousScreen({dynamic result}) {
    Get.back(result: result);
  }

  @override
  void navigateAndClearStack(String routeName, {dynamic arguments}) {
    Get.offAllNamed(routeName, arguments: arguments);
  }
}
