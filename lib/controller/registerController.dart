import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final usernameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  var isPasswordVisible = false.obs;
  RxBool isLoading = false.obs;

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// Fungsi untuk menampilkan snackbar
  void showSnackbar(String title, String message, {bool isError = false}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
    );
  }

  /// Fungsi untuk mengenkripsi password menggunakan SHA256
  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> register(String username, String email, String password) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      showSnackbar('Registrasi Gagal', 'Semua field wajib diisi!',
          isError: true);
      return;
    }

    isLoading.value = true;
    update();

    try {
      // Registrasi ke Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());

      // Simpan user info ke Firestore (TAPI TANPA PASSWORD)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'uid': userCredential.user!.uid,
        'email': email.trim(),
        'username': username.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      showSnackbar('Registrasi Berhasil', 'Silahkan login kembali');
      Get.offNamed('/login');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showSnackbar('Registrasi Gagal', 'Email sudah digunakan!',
            isError: true);
      } else {
        showSnackbar('Registrasi Gagal', 'Terjadi kesalahan: ${e.message}',
            isError: true);
      }
    } catch (e) {
      showSnackbar('Registrasi Gagal', 'Terjadi kesalahan: ${e.toString()}',
          isError: true);
    } finally {
      isLoading.value = false;
      update();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.onClose();
  }
}
