import 'package:arsneakers/controller/loginController.dart';
import 'package:arsneakers/widgets/customButtonWidget.dart';
import 'package:arsneakers/widgets/customTextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ayo Masuk Kembali!',
                    style: GoogleFonts.montserrat(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Silahkan masuk kembali dengan menginputkan email dan password yang sesuai pada saat kamu mendaftarkan akunmu!',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Lottie.network(
                      'https://lottie.host/f9e2a103-1104-432f-a41d-5f8751501e83/jH0KxLuAuC.json',
                      width: 250,
                      height: 240,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: controller.emailController,
                    focusNode: controller.emailFocus,
                    labelText: 'Email :',
                    hintText: 'Masukkan alamat email mu!',
                    borderColor: Colors.black,
                    focusedBorderColor: Colors.grey.shade800,
                    errorBorderColor: Colors.red,
                    fillColor: Colors.white,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  Obx(() => CustomTextField(
                        controller: controller.passwordController,
                        focusNode: controller.passwordFocus,
                        labelText: 'Password :',
                        hintText: 'Masukkan password mu!',
                        borderColor: Colors.black,
                        focusedBorderColor: Colors.grey.shade800,
                        errorBorderColor: Colors.red,
                        fillColor: Colors.white,
                        obscureText: !controller.isPasswordVisible.value,
                        suffixIcon: IconButton(
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password tidak boleh kosong!';
                          }
                          return null;
                        },
                      )),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Tidak punya akun? ',
                          style: GoogleFonts.montserrat()),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed("/register");
                        },
                        child: Text(
                          'Daftar!',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomButtonWidget(
                    onPressed: () {
                      controller.login();
                    },
                    text: 'Masuk',
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    borderColor: Colors.black,
                    borderWidth: 3.0,
                    pressedBackgroundColor: Colors.white,
                    pressedTextColor: Colors.black,
                    pressedBorderColor: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
