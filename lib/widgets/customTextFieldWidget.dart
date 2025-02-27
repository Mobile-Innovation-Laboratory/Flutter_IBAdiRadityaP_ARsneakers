import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String labelText;
  final String hintText;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color fillColor;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.labelText = 'Email :',
    this.hintText = 'Masukkan alamat email mu!',
    this.borderColor = Colors.black,
    this.focusedBorderColor = const Color(0xFF4A4A4A),
    this.errorBorderColor = Colors.red,
    this.fillColor = Colors.white,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autofocus: false,
      obscureText: obscureText,
      decoration: InputDecoration(
        isDense: true,
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 21,
          fontWeight: FontWeight.w800,
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusedBorderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorBorderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: errorBorderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
      ),
      style: GoogleFonts.montserrat(
        color: Colors.black,
        fontSize: 16,
      ),
      cursorColor: Colors.black,
      validator: validator,
    );
  }
}
