import 'package:get/get.dart';
import 'package:uas_mobile_dev/pages/login_page.dart';
import 'package:uas_mobile_dev/pages/main_menu.dart';
import 'package:uas_mobile_dev/pages/detail_makanan_page.dart';
import 'package:uas_mobile_dev/controllers/drawer_controller.dart';

class Routes {
  static const String login = "/login";
  static const String mainMenu = "/main-menu";
  static const String detailMakanan = "/detail-makanan";
  static final drawerController = Get.put(DrawerControllerX());

  static final myPages = [
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: mainMenu, page: () => MainMenu()),
    GetPage(name: detailMakanan, page: () => DetailMakananPage()),
  ];
}