import 'package:arsneakers/controller/cartController.dart';
import 'package:arsneakers/controller/detailProductController.dart';
import 'package:arsneakers/utils/arTestScreen.dart';
import 'package:arsneakers/widgets/customAppBarWidget.dart';
import 'package:arsneakers/widgets/customButtonWidget.dart';
import 'package:arsneakers/widgets/customDrawerWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailProductPage extends GetView<DetailProductController> {
  final String productId;

  const DetailProductPage({Key? key, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final cartController = Get.put(CartController());

    print("Debug: Received productId = $productId");

    if (productId.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text("Product ID is missing!")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: scaffoldKey, title: "ARsneakers"),
      drawer: const CustomDrawer(),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Produk tidak ditemukan.'));
          }

          var productData = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    productData['imageUrl'] ?? '',
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 50),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  productData['name'] ?? 'Nama Produk',
                  style: GoogleFonts.montserrat(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  productData['price'] != null
                      ? 'Rp ${productData['price']}'
                      : 'Harga tidak tersedia',
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: Color(0xFF004241),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  productData['description'] ?? 'Tidak ada deskripsi tersedia.',
                  style: GoogleFonts.montserrat(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text('Sisa stok:',
                        style: GoogleFonts.montserrat(fontSize: 16)),
                    const SizedBox(width: 5),
                    Text(
                      productData['stock']?.toString() ?? '0',
                      style: GoogleFonts.montserrat(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: CustomButtonWidget(
                    text: 'Masuk ke dunia AR',
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    borderColor: Colors.black,
                    borderWidth: 3.0,
                    pressedBackgroundColor: Colors.white,
                    pressedTextColor: Colors.black,
                    pressedBorderColor: Colors.black,
                    onPressed: () {
                      Get.to(() => ArTestScreen());
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: CustomButtonWidget(
                    text: 'Add to Cart',
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    borderColor: Colors.black,
                    borderWidth: 3.0,
                    pressedBackgroundColor: Colors.white,
                    pressedTextColor: Colors.black,
                    pressedBorderColor: Colors.black,
                    onPressed: () {
                      final product = {
                        'id': productId,
                        'name': productData['name'] ?? 'Nama Produk',
                        'imageUrl': productData['imageUrl'] ?? '',
                        'price': productData['price'] ?? 0,
                        'stock': productData['stock'] ?? 0,
                        'quantity': 1,
                      };

                      print("Produk ditambahkan ke cart: $product");

                      cartController.addToCart(product);
                      Get.snackbar(
                        "Berhasil",
                        "Produk ditambahkan ke keranjang!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Color(0xFF004241),
                        colorText: Colors.white,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
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
