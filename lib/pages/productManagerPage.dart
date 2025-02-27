import 'package:arsneakers/controller/productManagerController.dart';
import 'package:arsneakers/widgets/addProductScreenWidget.dart';
import 'package:arsneakers/widgets/customAppBarWidget.dart';
import 'package:arsneakers/widgets/customButtonWidget.dart';
import 'package:arsneakers/widgets/customDrawerWidget.dart';
import 'package:arsneakers/widgets/horizontalCardWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductManagerPage extends GetView<ProductManagerController> {
  const ProductManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return GetBuilder<ProductManagerController>(
        init: ProductManagerController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            key: scaffoldKey,
            appBar:
                CustomAppBar(scaffoldKey: scaffoldKey, title: 'Product List'),
            drawer: CustomDrawer(),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('products')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return Center(child: Text('No products available'));
                          }

                          var products = snapshot.data!.docs;

                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 2.6,
                            ),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              var product = products[index];
                              return SneakerCardWidget(
                                imageUrl: product['imageUrl'],
                                name: product['name'],
                                price: '\$${product['price']}',
                                quantity: product['stock'].toString(),
                                icon1: () {
                                  Get.to(
                                      () => AddProductScreen(product: product));
                                },
                                icon2: () async {
                                  controller.deleteProduct(
                                    product.id,
                                    product['imageUrl'] ?? "",
                                  );
                                },
                                iconData1: Icons.edit,
                                iconData2: Icons.restore_from_trash,
                                iconColor1: Color(0xFF004241),
                                iconColor2: Colors.red,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CustomButtonWidget(
                        onPressed: () {
                          Get.offAllNamed('/add');
                        },
                        text: 'Tambah Produk',
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        borderColor: Colors.black,
                        borderWidth: 3.0,
                        pressedBackgroundColor: Colors.white,
                        pressedTextColor: Colors.black,
                        pressedBorderColor: Colors.black,
                      ),
                    )
                  ],
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
        });
  }
}
