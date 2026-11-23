import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uas_mobile_dev/routers.dart';
import 'package:uas_mobile_dev/models/login_model.dart'; // Jangan lupa import model kamu

class LoginController extends GetxController {
  final TextEditingController txtUsername = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  var isLoading = false.obs;

  // 1. Tambahkan variabel Rxn<LoginModel> sesuai instruksi WA
  var loginModel = Rxn<LoginModel>();

  void login() async {
    if (txtUsername.text.trim().isEmpty || txtPassword.text.trim().isEmpty) {
      Get.snackbar(
        "Error", 
        "Username dan password harus terisi",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      final url = Uri.parse("https://mediadwi.com/api/latihan/login"); 

      final response = await http.post(
        url,
        body: {
          'username': txtUsername.text.toString(),
          'password': txtPassword.text.toString(),
        },
      );

      isLoading.value = false;

      if (response.statusCode == 200) {
        // 2. Masukkan parsing model di dalam if status code 200
        loginModel.value = loginModelFromJson(response.body);

        // 3. Cara menggunakan data modelnya (.status dan .message)
        if (loginModel.value?.status == true) {
          Get.snackbar(
            "Berhasil", 
            loginModel.value?.message ?? "Login success",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          Get.offNamed(Routes.mainMenu);

        } else {
          Get.snackbar(
            "Gagal", 
            loginModel.value?.message ?? "Login gagal",
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Gagal", 
          "Cek internet connection",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        "Error", 
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}