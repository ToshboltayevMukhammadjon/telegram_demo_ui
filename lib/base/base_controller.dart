import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:telegram_demo/core/constants/color.dart';

export 'package:get/get.dart';

abstract class BaseController extends GetxController {
  bool _isLoading = false;
  final Connectivity connectivity = Connectivity();
  ConnectivityResult connectivityResult = ConnectivityResult.none;

  @override
  void onInit() {
    checkConnection();
    connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.onInit();
  }

  Future<void> checkConnection() async {
    try {
      connectivityResult = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    return _updateConnectionStatus(connectivityResult);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    this.connectivityResult = result;
    update();
  }

  void setLoading(bool value) {
    _isLoading = value;
    update();
  }

  void showErrorMessage(String message) {
    Get.snackbar('error'.tr, message);
  }

  void showErrorMessageWithBackground(String message) {
    Get.snackbar(
      'error'.tr,
      message,
      backgroundColor: clrAssets,
      colorText: clrWhite,
    );
  }

  bool get isLoading => _isLoading;
}
