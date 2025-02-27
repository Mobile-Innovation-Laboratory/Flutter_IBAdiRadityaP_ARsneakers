import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final double borderWidth;
  final Color pressedBackgroundColor;
  final Color pressedTextColor;
  final Color pressedBorderColor;

  const CustomButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.borderColor = Colors.white,
    this.borderWidth = 2.0,
    this.pressedBackgroundColor = Colors.white,
    this.pressedTextColor = Colors.black,
    this.pressedBorderColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final isPressed = false.obs; 

    return GestureDetector(
      onTapDown: (_) => isPressed.value = true,
      onTapUp: (_) => isPressed.value = false,
      onTapCancel: () => isPressed.value = false,
      onTap: onPressed,
      child: Obx(() => Container(
            width: double.infinity,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isPressed.value ? pressedBackgroundColor : backgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isPressed.value ? pressedBorderColor : borderColor,
                width: borderWidth,
              ),
            ),
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                color: isPressed.value ? pressedTextColor : textColor,
              ),
            ),
          )),
    );
  }
}
