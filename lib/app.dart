import 'package:aadarsh_pvt_ltd/ui/authentication/splash/ui/splash_screen.dart';
import 'package:base_module/base/interfaces_service/dialog_service.dart';
import 'package:base_module/base/interfaces_service/dialog_service_impl.dart';
import 'package:base_module/base/interfaces_service/navigation__service_impl.dart';
import 'package:base_module/base/interfaces_service/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helper/routes/app_routes.dart';
import 'helper/routes/binding.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    _initApp();
    super.initState();
  }

  Future<void> _initApp() async {
    // Initialize GetX services
    Get.put<IDialogService>(DialogService(), permanent: true);
    Get.put<INavigationService>(NavigationService(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: SplashBinding(),
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.appRoutes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
