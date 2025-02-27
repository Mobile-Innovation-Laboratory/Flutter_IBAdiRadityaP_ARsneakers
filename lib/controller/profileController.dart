import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var username = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    String? storedEmail = prefs.getString('email');

    if (storedUsername == null || storedUsername.isEmpty) {
      print("Username not found in SharedPreferences");
      username.value = 'Guest';
    } else {
      username.value = storedUsername;
      print("Loaded username: $storedUsername");
    }
    
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('id');
    await prefs.remove('username');
    await prefs.remove('isLoggedin');
    await prefs.remove('email');
    Get.snackbar('Success', 'You have logged out');
    Get.offAllNamed('/login');
  }
}
