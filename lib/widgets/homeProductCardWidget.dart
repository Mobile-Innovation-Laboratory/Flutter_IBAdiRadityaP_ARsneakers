import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String price;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: backgroundColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 100,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 50),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                productName,
                style: GoogleFonts.montserrat(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Text(
              price,
              style: GoogleFonts.montserrat(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
