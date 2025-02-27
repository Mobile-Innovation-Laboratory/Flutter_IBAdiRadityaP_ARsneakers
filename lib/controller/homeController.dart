import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var carouselCurrentIndex = 0.obs;

  void updateCarouselIndex(int index) {
    carouselCurrentIndex.value = index;
  }

  RxString selectedCategory = 'ALL'.obs;

  void changeCategory(String category) {
    selectedCategory.value = category;
    update();
  }

  Future<QuerySnapshot> fetchProducts() {
    if (selectedCategory.value == 'ALL') {
      return FirebaseFirestore.instance.collection('products').get();
    } else {
      return FirebaseFirestore.instance
          .collection('products')
          .where('category', isEqualTo: selectedCategory.value)
          .get();
    }
  }
}
