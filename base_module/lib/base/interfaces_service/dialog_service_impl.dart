import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

abstract class IDialogService {
  void showSnackBar(String title, String message,
      {Duration duration,
      Color? backgroundColor,
      SnackPosition position = SnackPosition.BOTTOM,
      IconData? icon});

  void showLoading({String message});

  void hideLoading();
  void showLogoutDialog(Function() onLogin);
  void showToast(String message);
}
