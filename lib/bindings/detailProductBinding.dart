import 'package:arsneakers/controller/detailProductController.dart';
import 'package:get/get.dart';

class DetailProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProductController>(
      () => DetailProductController(),
    );
  }
}
