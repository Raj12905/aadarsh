import 'package:base_module/base/base_controller.dart';
import 'package:get/get.dart';

class NavigationBarController extends BaseController{
  final RxInt currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
}