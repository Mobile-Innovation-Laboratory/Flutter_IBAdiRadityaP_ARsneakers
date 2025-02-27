import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ProductManagerController extends GetxController {
  Future<void> deleteProduct(
      String productId, String imageUrl) async {
    try {
      // Hapus gambar dari Firebase Storage jika ada
      if (imageUrl.isNotEmpty) {
        await FirebaseStorage.instance.refFromURL(imageUrl).delete();
      }

      // Hapus produk dari Firestore
      await FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .delete();

      Get.snackbar("Sukses", "Produk berhasil dihapus",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "Gagal menghapus produk: ${e.toString()}",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
