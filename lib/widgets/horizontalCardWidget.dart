import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SneakerCardWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final String quantity;
  final VoidCallback icon1;
  final VoidCallback icon2;
  final VoidCallback? icon3;
  final IconData iconData1;
  final IconData iconData2;
  final IconData? optionalIcon;
  final Color iconColor1;
  final Color iconColor2;
  final Color? optionalIconColor;

  const SneakerCardWidget({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.quantity,
    required this.icon1,
    required this.icon2,
    required this.iconData1,
    required this.iconData2,
    required this.iconColor1,
    required this.iconColor2,
    this.icon3,
    this.optionalIcon,
    this.optionalIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 150,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Qty: $quantity',
                    style: GoogleFonts.montserrat(fontSize: 12),
                  ),
                  Text(
                    price,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: icon1,
                        icon: Icon(iconData1, color: iconColor1),
                      ),
                      IconButton(
                        onPressed: icon2,
                        icon: Icon(iconData2, color: iconColor2),
                      ),
                      if (icon3 != null && optionalIcon != null)
                        IconButton(
                          onPressed: icon3,
                          icon: Icon(optionalIcon,
                              color: optionalIconColor ?? Color(0xFF004241)),
                        ),
                    ],
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
