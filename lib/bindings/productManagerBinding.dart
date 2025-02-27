import 'package:arsneakers/controller/productManagerController.dart';
import 'package:get/get.dart';

class ProductManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductManagerController>(
      () => ProductManagerController(),
    );
  }
}
