import 'package:get/get.dart';

abstract class BaseBinding<T extends GetxController> extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<T>(() => createController());
  }
  T createController();
}

