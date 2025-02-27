import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartController extends GetxController {
  var cartItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String cartString = jsonEncode(cartItems);

    print("Data yang disimpan ke SharedPreferences: $cartString");

    await prefs.setString('cart', cartString);
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartString = prefs.getString('cart');

    print(
        "Data dari SharedPreferences: $cartString"); 

    if (cartString != null) {
      try {
        List<Map<String, dynamic>> decodedCart =
            List<Map<String, dynamic>>.from(jsonDecode(cartString));

        cartItems.assignAll(decodedCart);
        print(
            "Berhasil decode dan assign ke cartItems: $decodedCart"); 
      } catch (e) {
        print("ERROR decoding cart: $e"); 
      }
    } else {
      print("⚠️ Tidak ada data cart di SharedPreferences.");
    }
  }

  void addToCart(Map<String, dynamic> product) {
    var existingProductIndex =
        cartItems.indexWhere((p) => p['id'] == product['id']);

    if (existingProductIndex != -1) {
      cartItems[existingProductIndex]['quantity'] += 1;
    } else {
      cartItems.add({
        'id': product['id'],
        'name': product['name'],
        'price': product['price'],
        'stock': product['stock'],
        'quantity': 1,
        'imageUrl': product['imageUrl'] ?? '', 
      });
    }

    saveCart(); 
  }

  void increaseQuantity(String id) {
    int index = cartItems.indexWhere((item) => item['id'] == id);
    if (index != -1 &&
        cartItems[index]['quantity'] < cartItems[index]['stock']) {
      cartItems[index]['quantity'] += 1;
      saveCart();
      cartItems.refresh(); 
    }
  }

  void decreaseQuantity(String id) {
    int index = cartItems.indexWhere((item) => item['id'] == id);
    if (index != -1 && cartItems[index]['quantity'] > 1) {
      cartItems[index]['quantity'] -= 1;
      saveCart();
      cartItems.refresh(); 
    }
  }

  void removeProduct(String id) {
    cartItems.removeWhere((item) => item['id'] == id);
    saveCart();
    cartItems.refresh(); 
  }

  double getTotalPrice() {
    return cartItems.fold(
        0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  void clearCart() async {
    cartItems.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('cart');
  }
}
