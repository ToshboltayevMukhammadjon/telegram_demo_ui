import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telegram_demo/base/base_controller.dart';

class MainController extends BaseController with SingleGetTickerProviderMixin{

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

}