import 'package:base_module/shared_pref/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import '../remote/auth_repository.dart';
import 'interfaces_service/dialog_service_impl.dart';
import 'interfaces_service/navigation__service_impl.dart';

class BaseController extends GetxController {
  late final IDialogService _dialogService;
  late final INavigationService _navigationService;
  final _authRepository = AuthRepository();
  final _sharedPrefs = SharedPrefs();

    var isLoading = false.obs;

  BaseController() {
    _dialogService = Get.find<IDialogService>();
    _navigationService = Get.find<INavigationService>();
  }

  SharedPrefs get sharedPrefs => _sharedPrefs;
  AuthRepository get authRepository => _authRepository;
  AppUpdateInfo? _updateInfo;

  Future<void> _checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      _updateInfo = info;
      debugPrint("update: $_updateInfo");
    }).whenComplete(() {
      if (_updateInfo?.updateAvailability ==
          UpdateAvailability.updateAvailable) {
        _showUpdateDialog();
      }
    });
  }

  _showUpdateDialog() {
    return Dialogs.materialDialog(
        color: Colors.white,
        msg: "Kindly update app, latest version:1.0.${_updateInfo!.availableVersionCode}",
        title: "App Update!",
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
              backToPreviousScreen();
            },
            text: 'Cancel',
            color: Colors.orange,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
          IconsButton(
            onPressed: () {
              backToPreviousScreen();
              InAppUpdate.performImmediateUpdate().catchError(
                  (e) => {showSnackBar('Error', e.toString()), e.toString()});
            },
            text: 'Update Now',
            color: Colors.green,
            textStyle: const TextStyle(color: Colors.white),
            iconColor: Colors.white,
          ),
        ]);
  }

  @override
  void onInit() async {
    super.onInit();
    //_checkForUpdate();
  }

  Future<String?> getUserId() async {
    return await _sharedPrefs.getUserId();
  }

  void showSnackBar(
    String title,
    String message, {
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    SnackPosition position = SnackPosition.BOTTOM,
    IconData? icon,
  }) {

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
   /* _dialogService.showSnackBar(title, message,
        duration: duration,
        backgroundColor: backgroundColor,
        position: position,
        icon: icon);*/
  }

  void handleError(String? errorMessage, {String title = "Error"}) {
    showSnackBar(title, errorMessage??'Something went wrong', backgroundColor: Colors.red);
  }

  void showLoading({String message = "Loading..."}) {
    _dialogService.showLoading(message: message);
  }

  void hideLoading() {
    _dialogService.hideLoading();
  }

  void navigateTo(String routeName, {dynamic arguments}) {
    _navigationService.navigateTo(routeName, arguments: arguments);
  }

  void navigateAndClearStack(String routeName, {dynamic arguments}) {
    _navigationService.navigateAndClearStack(routeName);
  }

  void backToPreviousScreen({dynamic result}) {
    _navigationService.backToPreviousScreen();
  }

  void showToast(String message) {
    _dialogService.showSnackBar('', message);
  }

  void logoutAndClearData(newRouteName) {
    _sharedPrefs.clear();
    navigateAndClearStack(newRouteName);
  }

  void showLogoutDialog(newRouteName) {
    _dialogService.showLogoutDialog(() => {logoutAndClearData(newRouteName)});
  }

}
