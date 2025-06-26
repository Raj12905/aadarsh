import 'package:aadarsh_pvt_ltd/helper/routes/routes_names.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/complete_request/ui/complete_request_screen.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/home/ui/home_Screen.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/notification_data/ui/notification_data_screen.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/profile/controller/profile_controller.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/profile/ui/profile_screen.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/reject_request/ui/reject__request_sreen.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/request_details/ui/request_details_screen.dart';
import 'package:aadarsh_pvt_ltd/ui/screens/request_pending/ui/request_pending_screen.dart';
import 'package:get/get.dart';

import '../../ui/authentication/login/ui/login_screen.dart';
import '../../ui/authentication/splash/ui/splash_screen.dart';
import '../../ui/screens/navigation_bar/ui/navigation_bar_screen.dart';
import 'binding.dart';

class AppRoutes {
  static List<GetPage> appRoutes = [
    GetPage(
        name: RoutesNames.splashScreen,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: RoutesNames.loginScreen,
        page: () => LoginScreen(),
        binding: LoginBinding()),
    GetPage(
        name: RoutesNames.completeRequestScreen,
        page: () => CompleteRequestScreen(),
        binding: CompleteRequestBinding()),
    GetPage(
        name: RoutesNames.homeScreen,
        page: () => HomeScreen(),
        binding: HomeBinding()),
    GetPage(
        name: RoutesNames.notificationDataScreen,
        page: () => NotificationDataScreen(),
        binding: NotificationDataBinding()),
    GetPage(
        name: RoutesNames.rejectRequestScreen,
        page: () => RejectRequestScreen(),
        binding: RejectRequestBinding()),
    GetPage(
        name: RoutesNames.requestDetailsScreen,
        page: () => RequestDetailsScreen(),
        binding: RequestDetailsBinding()),
    GetPage(
        name: RoutesNames.requestPendingScreen,
        page: () => RequestPendingScreen(),
        binding: RequestPendingBinding()),
    GetPage(
        name: RoutesNames.navigationBarScreen,
        page: () => NavigationBarScreen(),
        binding: NavigationBarBinding()),
    GetPage(
        name: RoutesNames.profileScreen,
        page: () => ProfileScreen(),
        binding: ProfileBinding()),
  ];
}
