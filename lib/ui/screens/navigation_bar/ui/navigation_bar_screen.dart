import 'package:aadarsh_pvt_ltd/ui/screens/navigation_bar/controller/navigation_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../themes/app_color.dart';
import '../../home/ui/home_Screen.dart';
import '../../profile/ui/profile_screen.dart';

class NavigationBarScreen extends StatelessWidget {
  NavigationBarScreen({super.key});
  final controller =
      Get.put<NavigationBarController>(NavigationBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: [
              HomeScreen(),
              ProfileScreen(),
            ],
          )),
      bottomNavigationBar: Obx(() => _buildBottomNavBar()),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.secondaryColor,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changePage,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.currentIndex.value == 0
                    ? Colors.white.withOpacity(0.2)
                    : Colors.transparent,
              ),
              child: Icon(Icons.home_rounded, size: 26),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.currentIndex.value == 1
                    ? Colors.white.withOpacity(0.2)
                    : Colors.transparent,
              ),
              child: Icon(Icons.person_rounded, size: 26),
            ),
            label: 'Profile',
          ),
        ],
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }
}
