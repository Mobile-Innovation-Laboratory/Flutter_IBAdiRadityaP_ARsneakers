import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  var isPasswordVisible = false.obs;
  RxBool isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  /// Fungsi untuk menampilkan snackbar
  void showSnackbar(String title, String message, {bool isError = false}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor:
          isError ? Get.theme.colorScheme.error : Get.theme.colorScheme.primary,
      colorText: isError
          ? Get.theme.colorScheme.onError
          : Get.theme.colorScheme.onPrimary,
    );
  }

  /// Fungsi untuk mengenkripsi password menggunakan SHA256
  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Validasi input
  String? validateInput() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return "Email dan password wajib diisi!";
    }
    return null;
  }

  /// Proses login dengan Firestore
  Future<void> login() async {
    final validationError = validateInput();
    if (validationError != null) {
      showSnackbar('Login Gagal', validationError, isError: true);
      return;
    }

    isLoading.value = true;
    update();

    try {
      // Login ke Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

      // Ambil data pengguna dari Firestore berdasarkan UID
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (!docSnapshot.exists) {
        showSnackbar('Login Gagal', 'Data pengguna tidak ditemukan!',
            isError: true);
        return;
      }

      final userData = docSnapshot.data()!;

      // Simpan status login di SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', userCredential.user!.uid);
      await prefs.setString('username', userData['username']);
      await prefs.setBool('isLoggedin', true);
      await prefs.setString('email', userData['email']);

      showSnackbar(
          'Login Berhasil', 'Selamat datang, ${userData['username']}!');

      Get.offNamed('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackbar('Login Gagal', 'Email tidak terdaftar!', isError: true);
      } else if (e.code == 'wrong-password') {
        showSnackbar('Login Gagal', 'Password salah!', isError: true);
      } else {
        showSnackbar('Login Gagal', 'Terjadi kesalahan: ${e.message}',
            isError: true);
      }
    } catch (e) {
      showSnackbar('Login Gagal', 'Terjadi kesalahan: ${e.toString()}',
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

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedin') ?? false;

    if (isLoggedIn) {
      Get.offNamed('/home'); // Redirect ke home jika sudah login
    }
  }
}
