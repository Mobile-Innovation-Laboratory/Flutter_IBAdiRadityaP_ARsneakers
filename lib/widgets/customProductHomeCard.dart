import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomProductHomeCard extends StatelessWidget {
  final String productId;
  final String imageUrl;
  final String productName;
  final String price;
  final Color priceColor;

  const CustomProductHomeCard({
    super.key,
    required this.productId,
    required this.imageUrl,
    required this.productName,
    required this.price,
    this.priceColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.to(() => ProductDetailPage(productId: productId));
      },
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    price,
                    style: GoogleFonts.montserrat(
                      color: priceColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
