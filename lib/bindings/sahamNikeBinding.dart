import 'package:arsneakers/controller/sahamNikeController.dart';
import 'package:get/get.dart';

class SahamNikeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SahamNikeController>(
      () => SahamNikeController(),
    );
  }
}
