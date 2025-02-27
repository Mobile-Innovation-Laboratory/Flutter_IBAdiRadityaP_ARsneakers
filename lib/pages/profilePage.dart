import 'package:arsneakers/controller/profileController.dart';
import 'package:arsneakers/widgets/customAppBarWidget.dart';
import 'package:arsneakers/widgets/customDrawerWidget.dart';
import 'package:arsneakers/widgets/customProfileCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            key: scaffoldKey,
            appBar: CustomAppBar(scaffoldKey: scaffoldKey, title: "Profile"),
            drawer: const CustomDrawer(),
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome! ',
                          style: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Obx(
                          () => Text(
                            '${controller.username.value}',
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(0, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: const Color(0xFFD0D0D0), width: 1),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomProfileCard(
                                  icon: Icons.add_box,
                                  text: 'Manage Produk',
                                  color: Color(0xFF004241),
                                  onTap: () {
                                    Get.offAllNamed('/product-manager');
                                  },
                                ),
                                CustomProfileCard(
                                  icon: Icons.shopping_cart_rounded,
                                  text: 'Cek Keranjang',
                                  color: Colors.orange,
                                  onTap: () {
                                    Get.offAllNamed('/cart');
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomProfileCard(
                                  icon: Icons.arrow_back,
                                  text: 'Logout',
                                  color: Colors.red,
                                  onTap: () {
                                    controller.logout();
                                  },
                                ),
                                CustomProfileCard(
                                  icon: Icons.query_stats_sharp,
                                  text: 'Saham Nike',
                                  color: Colors.blue,
                                  onTap: () {
                                    Get.offAllNamed('/saham');
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: CustomBottomBar(),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xFFF0F4F8),
              onPressed: () {
                Get.toNamed('/product-manager');
              },
              child: Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        });
  }
}
