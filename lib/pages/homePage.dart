import 'package:arsneakers/controller/homeController.dart';
import 'package:arsneakers/pages/detailProductPage.dart';
import 'package:arsneakers/widgets/customAppBarWidget.dart';
import 'package:arsneakers/widgets/customDrawerWidget.dart';
import 'package:arsneakers/widgets/homeProductCardWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final CarouselController carouselController = CarouselController();

    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          key: scaffoldKey,
          appBar: CustomAppBar(scaffoldKey: scaffoldKey, title: "ARsneakers"),
          drawer: const CustomDrawer(),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text(
                        'Welcome!',
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 8, top: 6, bottom: 6, right: 76),
                      child: Text(
                        'ARsneaker hadir untuk memberikan sneakers pilihan terbaik bagi Anda! Kami menyediakan koleksi sepatu second berkualitas tinggi yang telah dikurasi secara ketat untuk memastikan keaslian dan kondisi terbaik',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 4,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          CarouselSlider(
                            items: [
                              Lottie.network(
                                'https://lottie.host/cc2506d6-9a5b-4c7f-8f3b-ab5a1cdc5ed6/2eZVU839Ig.json',
                                width: 200,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                              Lottie.network(
                                'https://lottie.host/109d2c93-af55-4d8b-8ce2-013af015c81d/UkojuPXMOx.json',
                                width: 200,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                              Lottie.network(
                                'https://lottie.host/01e95583-7aec-4abe-a244-05f1e6216f46/fYIzfavhBs.json',
                                width: 200,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ],
                            options: CarouselOptions(
                              initialPage: 1,
                              viewportFraction: 0.5,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.25,
                              enableInfiniteScroll: true,
                              scrollDirection: Axis.horizontal,
                              autoPlay: false,
                              onPageChanged: (index, _) {
                                controller.carouselCurrentIndex.value = index;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: ['ALL', 'NIKE', 'ADIDAS', 'PUMA']
                                .map((category) {
                              return Obx(() {
                                bool isSelected =
                                    controller.selectedCategory.value ==
                                        category;

                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      controller.changeCategory(category);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isSelected
                                          ? Colors.black
                                          : Colors.white,
                                      foregroundColor: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      side: BorderSide(
                                        color: isSelected
                                            ? Colors.black
                                            : Colors.grey,
                                        width: 1,
                                      ),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(category,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                );
                              });
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    FutureBuilder<QuerySnapshot>(
                      future: controller.fetchProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(child: Text('Produk tidak ditemukan.'));
                        }

                        var products = snapshot.data!.docs.map((doc) {
                          var data = doc.data() as Map<String, dynamic>;
                          data['id'] = doc.id;
                          return data;
                        }).toList();

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(10),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.9,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            var productData = products[index];
                            return ProductCard(
                              imageUrl: productData['imageUrl'] ?? '',
                              productName: productData['name'] ?? 'No Name',
                              price: productData['price'] != null
                                  ? 'Rp ${productData['price']}'
                                  : 'Harga tidak tersedia',
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              onTap: () {
                                print(
                                    "Debug: productData['id'] = ${productData['id']}");
                                if (productData.containsKey('id') &&
                                    productData['id'] != null) {
                                  Get.to(() => DetailProductPage(
                                      productId: productData['id']));
                                } else {
                                  print("Error: productId is null or missing!");
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
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
      },
    );
  }
}
