import 'package:arsneakers/controller/welcomeController.dart';
import 'package:arsneakers/widgets/customButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        // Tambahkan padding di seluruh halaman
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Lottie.network(
                    'https://lottie.host/7e99d44c-baf4-4deb-aa21-5507c06abe5e/h4zaMKXFed.json',
                    width: 350,
                    height: 280,
                    fit: BoxFit.fitWidth,
                  ),
                ),

                // Welcome Text
                Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: Text(
                    'Welcome To ARsneaker',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 35,
                      fontWeight: FontWeight.w800,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                // Description
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    'ARsneaker adalah aplikasi e-commerce berbasis mobile yang khusus menjual sepatu second dengan fitur teknologi Augmented Reality (AR). Dengan AR, pengguna bisa melihat tampilan sepatu secara 3D dan mencobanya secara virtual sebelum membeli.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // Daftar Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 17),
                  child: CustomButtonWidget(
                    onPressed: () {
                      Get.toNamed("/register");
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
                ),

                // Masuk Button
                CustomButtonWidget(
                  onPressed: () {
                    Get.toNamed("/login");
                  },
                  text: 'Masuk',
                  backgroundColor: Colors.white,
                  textColor: Colors.black,
                  borderColor: Colors.black,
                  borderWidth: 3.0,
                  pressedBackgroundColor: Colors.black,
                  pressedTextColor: Colors.white,
                  pressedBorderColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
