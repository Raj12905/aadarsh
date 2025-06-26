import 'package:aadarsh_pvt_ltd/ui/screens/complete_request/controller/complete_request_controller.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/navigation_bar/controller/navigation_bar_controller.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/notification_data/controller/notification_data_controller.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/profile/controller/profile_controller.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/reject_request/controller/reject_request_controller.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/request_details/cotroller/request_details_controller.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/request_pending/controller/request_pending_controller.dart';
import 'package:base_module/base/base_binding.dart';
import '../../ui/authentication/login/controller/login_controller.dart';
import '../../ui/authentication/splash/controller/splash_controller.dart';
import '../../ui/screens/home/controller/home_conroller.dart';

class SplashBinding extends BaseBinding<SplashController> {
  @override
  SplashController createController() {
    return SplashController();
  }
}

class LoginBinding extends BaseBinding<LoginController> {
  @override
  LoginController createController() {
    return LoginController();
  }
}

class CompleteRequestBinding extends BaseBinding<CompleteRequestController> {
  @override
  CompleteRequestController createController() {
    return CompleteRequestController();
  }
}

class HomeBinding extends BaseBinding<HomeController> {
  @override
  HomeController createController() {
    return HomeController();
  }
}

class NotificationDataBinding extends BaseBinding<NotificationDataController> {
  @override
  NotificationDataController createController() {
    return NotificationDataController();
  }
}

class RejectRequestBinding extends BaseBinding<RejectRequestController> {
  @override
  RejectRequestController createController() {
    return RejectRequestController();
  }
}

class RequestDetailsBinding extends BaseBinding<RequestDetailsController> {
  @override
  RequestDetailsController createController() {
    return RequestDetailsController();
  }
}

class RequestPendingBinding extends BaseBinding<RequestPendingController> {
  @override
  RequestPendingController createController() {
    return RequestPendingController();
  }
}

class NavigationBarBinding extends BaseBinding<NavigationBarController> {
  @override
  NavigationBarController createController() {
    return NavigationBarController();
  }
}

class ProfileBinding extends BaseBinding<ProfileController> {
  @override
  ProfileController createController() {
    return ProfileController();
  }
}
