import 'package:arsneakers/routes/appPages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Pastikan ini selesai sebelum runApp()

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Terjadi kesalahan: ${snapshot.error}')),
            ),
          );
        }
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: snapshot.data == true ? '/home' : AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: (context, child) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: child ?? SizedBox.shrink(),
            );
          },
        );
      },
    );
  }

  /// Mengecek apakah user sudah login
  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedin') ?? false;
  }
}
