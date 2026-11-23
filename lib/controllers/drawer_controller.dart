import 'package:uas_mobile_dev/menu/feat_page.dart';
import 'package:uas_mobile_dev/menu/home_page.dart';
import 'package:uas_mobile_dev/menu/profile_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../models/menu_model.dart';

class DrawerControllerX extends GetxController {
  var selectedIndex = 0.obs;

  final List<MenuModel> menuItems = [
    MenuModel(title: 'Home', icon: Icons.dashboard),
    MenuModel(title: 'Features', icon: Icons.apps),
    MenuModel(title: 'Profile', icon: Icons.person),
  ];

  final List<Widget> pages = [
    HomePage(),
    const FeatPage(),
    const ProfilePage(),
  ];

  void changePage(int index) {
    selectedIndex.value = index;
    Get.back();
  }
}