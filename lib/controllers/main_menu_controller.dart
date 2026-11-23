import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:uas_mobile_dev/menu/home_page.dart';
import 'package:uas_mobile_dev/menu/feat_page.dart';
import 'package:uas_mobile_dev/menu/profile_page.dart';

class MainMenuController extends  GetxController {
  //variable tanda untuk index stack body mana yang akan tampil
  final RxInt selectedIndex = 0.obs;

  void changePage(int index){
    selectedIndex.value = index;
  }

  List<Widget> listPages = [HomePage(), FeatPage(), ProfilePage()];
}