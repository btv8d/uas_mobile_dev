import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_mobile_dev/controllers/login_controller.dart';
import 'package:uas_mobile_dev/components/custom_button.dart';
import 'package:uas_mobile_dev/components/custom_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih bersih ala Instagram
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. Logo Teks Instagram (Menggunakan Text standar dengan GoogleFonts)
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontSize: 55,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                
                // 2. Input Username / Email
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: CustomTextfield(
                    myHint: "Phone number, username, or email",
                    txtController: controller.txtUsername,
                  ),
                ),
                
                // 3. Input Password
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: CustomTextfield(
                    myHint: "Password",
                    txtController: controller.txtPassword,
                  ),
                ),
                
                // 4. Teks "Forgot password?" di sebelah kanan
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // 5. Tombol Log In dengan Obx (Loading State)
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  }
                  return CustomButton(
                    textButton: "Log in",
                    textColor: Colors.white,
                    buttonColor: Colors.blue, // Warna biru khas tombol ig
                    onPressed: () {
                      controller.login();
                    },
                  );
                }),
                const SizedBox(height: 24),

                // 6. Garis Pembatas "OR"
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 24),

                // 7. Tombol Alternatif
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.facebook, color: Colors.blue),
                  label: const Text(
                    "Continue as Stevanie Wang",
                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ),
                
                const SizedBox(height: 60),

                // 8. Footer "Don't have an account? Sign up."
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Sign up.",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}