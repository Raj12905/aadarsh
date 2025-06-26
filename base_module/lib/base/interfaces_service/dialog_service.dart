import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';

import 'dialog_service_impl.dart';

class DialogService implements IDialogService {

  @override
  void showSnackBar(String title, String message, {Duration duration = const Duration(seconds: 3), Color? backgroundColor, SnackPosition position = SnackPosition.BOTTOM, IconData? icon}) {
    Get.snackbar(title, message,duration: duration,backgroundColor: backgroundColor,snackPosition: position);
  }

  @override
  void showLoading({String message = "Loading..."}) {
    Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);
  }

  @override
  void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

  @override
  void showToast(String message) {
    Get.showSnackbar(GetSnackBar(
      message: message,
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  void showLogoutDialog(Function() onLogout) {
       Dialogs.materialDialog(
        color: Colors.white,
        msg:
        "Are you sure want to logout?",
        title: "Confirm Logout",
        titleStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontFamily: "openSans",
          fontWeight: FontWeight.bold,
        ),
        msgStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontFamily: "openSans",
          fontWeight: FontWeight.bold,
        ),
        context: Get.context!,
        actions: [
          IconsButton(
            onPressed: () {
              // Dismiss the dialog
              Get.back();
            },
            shape: RoundedRectangleBorder(side: BorderSide(color: Color(0xFF6A11CB))),
            text: 'Cancel',
            textStyle: const TextStyle(color: Colors.black),
            iconColor: Colors.red,
          ),
          IconsButton(
            onPressed: () {
              // Redirect user to login screen
              Get.back(); // Close dialog before navigating
             onLogout();
            },
            text: 'Logout',
            color: Colors.red,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ],
      );


  }
}
