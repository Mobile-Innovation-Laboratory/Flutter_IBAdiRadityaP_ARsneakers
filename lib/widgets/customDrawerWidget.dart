import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 60, left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Drawer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "ARsneakers",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.black),
              title: Text(
                "Home",
                style: GoogleFonts.montserrat(),
              ),
              onTap: () {
                Get.offAllNamed('/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.black),
              title: Text("Keranjang", style: GoogleFonts.montserrat()),
              onTap: () {
                Get.offAllNamed('/cart');
              },
            ),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.black),
              title: Text("Profile", style: GoogleFonts.montserrat()),
              onTap: () {
                Get.offAllNamed('/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.query_stats, color: Colors.black),
              title: Text("Saham Nike", style: GoogleFonts.montserrat()),
              onTap: () {
                Get.offAllNamed('/saham');
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_box, color: Colors.black),
              title: Text("Tambah Produk", style: GoogleFonts.montserrat()),
              onTap: () {
                Get.offAllNamed('/product-manager');
              },
            ),
          ],
        ),
      ),
    );
  }
}
