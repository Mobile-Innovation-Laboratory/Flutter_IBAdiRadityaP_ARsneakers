import 'package:arsneakers/controller/cartController.dart';
import 'package:arsneakers/widgets/customAppBarWidget.dart';
import 'package:arsneakers/widgets/customButtonWidget.dart';
import 'package:arsneakers/widgets/customDrawerWidget.dart';
import 'package:arsneakers/widgets/horizontalCardWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPage extends GetView<CartController> {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: scaffoldKey, title: 'Cart'),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: Obx(() {
              if (controller.cartItems.isEmpty) {
                return const Center(child: Text('Keranjang kosong.'));
              }
              return ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  var product = controller.cartItems[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SneakerCardWidget(
                      imageUrl: product['imageUrl'] ?? '',
                      name: product['name'] ?? 'Produk Tanpa Nama',
                      price: 'Rp ${product['price']?.toString() ?? '0'}',
                      quantity: product['quantity']?.toString() ?? '0',
                      icon1: () {
                        if ((product['quantity'] ?? 0) <
                            (product['stock'] ?? 0)) {
                          controller.increaseQuantity(product['id'].toString());
                        } else {
                          Get.snackbar(
                            "Gagal",
                            "Stok tidak mencukupi!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      icon2: () {
                        if ((product['quantity'] ?? 0) > 1) {
                          controller.decreaseQuantity(product['id'].toString());
                        } else {
                          Get.snackbar(
                            "Gagal",
                            "Minimal jumlah 1!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        }
                      },
                      iconData1: Icons.add_box_rounded,
                      iconData2: Icons.remove_circle,
                      icon3: () =>
                          controller.removeProduct(product['id'].toString()),
                      iconColor1: Color(0xFF004241),
                      iconColor2: Colors.red,
                      optionalIcon: Icons.restore_from_trash,
                      optionalIconColor: Colors.red,
                    ),
                  );
                },
              );
            })),
            const SizedBox(height: 20),
            Obx(() => Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Total: Rp ${controller.getTotalPrice().toStringAsFixed(0)}',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF004241),
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
                child: CustomButtonWidget(
                  text: 'Order',
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  borderColor: Colors.black,
                  borderWidth: 3.0,
                  pressedBackgroundColor: Colors.white,
                  pressedTextColor: Colors.black,
                  pressedBorderColor: Colors.black,
                  onPressed: () {
                    double totalHarga = controller.getTotalPrice();

                    Get.offAllNamed('/invoice', arguments: {
                      'totalHarga': totalHarga,
                    });

                    Get.snackbar(
                      "Sukses",
                      "Pesanan Selesai",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Color(0xFF004241),
                      colorText: Colors.white,
                    );

                    controller.clearCart();
                  },
                )),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
