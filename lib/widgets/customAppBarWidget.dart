import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;

  const CustomAppBar({
    Key? key,
    required this.scaffoldKey,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: Icon(Icons.dehaze, color: Colors.black, size: 24),
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 23,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.0,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.shopping_cart, color: Colors.black, size: 24),
          onPressed: () {
            Get.offAllNamed('/cart');
          },
        ),
      ],
      centerTitle: true,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      shadowColor: Colors.black.withOpacity(0.3),
      child: SizedBox(
        height: 55,
        child: BottomAppBar(
          color: Color(0xFFF0F4F8),
          shape: CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, size: 30),
                onPressed: () {
                  Get.offAllNamed('/home');
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_back, size: 30),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
