import 'package:arsneakers/controller/invoiceController.dart';
import 'package:get/get.dart';

class InvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceController>(
      () => InvoiceController(),
    );
  }
}
