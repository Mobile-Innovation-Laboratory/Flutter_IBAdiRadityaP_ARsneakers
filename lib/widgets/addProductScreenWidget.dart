import 'package:arsneakers/widgets/customAppBarWidget.dart';
import 'package:arsneakers/widgets/customButtonWidget.dart';
import 'package:arsneakers/widgets/customDrawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatefulWidget {
  final QueryDocumentSnapshot<Object?>? product;

  AddProductScreen({this.product});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      var data = widget.product!.data() as Map<String, dynamic>;
      nameController.text = data['name'];
      descriptionController.text = data['description'];
      stockController.text = data['stock'].toString();
      priceController.text = data['price'].toString();
      categoryController.text = data['category'];
      imageUrlController.text = data['imageUrl'] ?? '';
    }
  }

  Future<void> saveProduct() async {
    if (nameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        stockController.text.isEmpty ||
        priceController.text.isEmpty ||
        categoryController.text.isEmpty ||
        imageUrlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Semua field harus diisi")),
      );
      return;
    }

    try {
      Map<String, dynamic> productData = {
        'name': nameController.text,
        'description': descriptionController.text,
        'stock': int.parse(stockController.text),
        'price': double.parse(priceController.text),
        'category': categoryController.text,
        'imageUrl': imageUrlController.text,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (widget.product == null) {
        // Tambah produk baru
        await FirebaseFirestore.instance
            .collection('products')
            .add(productData);
      } else {
        // Update produk yang ada
        await FirebaseFirestore.instance
            .collection('products')
            .doc(widget.product!.id)
            .update(productData);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(widget.product == null
                ? "Produk ditambahkan"
                : "Produk diperbarui")),
      );

      Get.back();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Colors.white,
      key: scaffoldKey,
      appBar: CustomAppBar(scaffoldKey: scaffoldKey, title: "ARsneakers"),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Nama Produk")),
              TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: "Deskripsi")),
              TextField(
                  controller: stockController,
                  decoration: InputDecoration(labelText: "Stok"),
                  keyboardType: TextInputType.number),
              TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: "Harga"),
                  keyboardType: TextInputType.number),
              TextField(
                  controller: categoryController,
                  decoration: InputDecoration(labelText: "Kategori")),
              SizedBox(height: 10),

              // Input URL gambar
              TextField(
                controller: imageUrlController,
                decoration: InputDecoration(labelText: "URL Gambar Produk"),
              ),
              imageUrlController.text.isNotEmpty
                  ? Image.network(imageUrlController.text, height: 100)
                  : Text("Masukkan URL gambar"),

              SizedBox(height: 20),
              CustomButtonWidget(
                onPressed: () async {
                  await saveProduct();
                },
                text: widget.product == null
                    ? "Tambahkan Produk"
                    : "Perbarui Produk",
                backgroundColor: Color(0xFF004241),
                textColor: Colors.white,
                borderColor: Color(0xFF004241),
                pressedBackgroundColor: Colors.white,
                pressedTextColor: Colors.black,
                pressedBorderColor: Colors.black,
              ),
              SizedBox(height: 20),
              CustomButtonWidget(
                onPressed: () {
                  Get.offAllNamed('/product-manager');
                },
                text: "Batal",
                backgroundColor: Colors.red,
                textColor: Colors.white,
                borderColor: Colors.red,
                pressedBackgroundColor: Colors.white,
                pressedTextColor: Colors.black,
                pressedBorderColor: Colors.red,
              ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
