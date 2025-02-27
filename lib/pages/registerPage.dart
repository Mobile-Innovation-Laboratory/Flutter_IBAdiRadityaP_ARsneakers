import 'package:arsneakers/controller/registerController.dart';
import 'package:arsneakers/widgets/customButtonWidget.dart';
import 'package:arsneakers/widgets/customTextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Buat Akun!',
                          style: GoogleFonts.montserrat(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Silahkan daftarkan dirimu dengan menginputkan email dan password agar kamu bisa mengakses aplikasi kami',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: Lottie.network(
                            'https://lottie.host/e8a3f83c-72d7-4d0b-b2da-01c996b764fb/kaGAjCUD4e.json',
                            width: 250,
                            height: 240,
                            fit: BoxFit.contain,
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
                        SizedBox(height: 20),
                        CustomTextField(
                          controller: controller.usernameController,
                          focusNode: controller.usernameFocus,
                          labelText: 'Username :',
                          hintText: 'Masukkan nama mu!',
                          borderColor: Colors.black,
                          focusedBorderColor: Colors.grey.shade800,
                          errorBorderColor: Colors.red,
                          fillColor: Colors.white,
                        ),
                        SizedBox(height: 20),
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
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Sudah punya akun? ',
                                style: GoogleFonts.montserrat()),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed("/login");
                              },
                              child: Text(
                                'Masuk!',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        CustomButtonWidget(
                          onPressed: () {
                            controller.register(
                              controller.usernameController.text.trim(),
                              controller.emailController.text.trim(),
                              controller.passwordController.text.trim(),
                            );
                          },
                          text: 'Daftar',
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
              ),
            ));
      },
    );
  }
}
