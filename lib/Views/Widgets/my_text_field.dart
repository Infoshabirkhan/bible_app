import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final OutlineInputBorder? border;
  final Widget? suffixIcon;
  final int maxLines;
  final bool? obscureText;
  final bool? enabled;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final OutlineInputBorder? disabledBorder;
  final String? Function(String?)? validator;

  final TextAlign? textAlign;
  const MyTextField({
    Key? key,
    this.textAlign = TextAlign.left,
    this.inputFormatter,
    this.keyboardType,
    this.enabled = true,
    this.disabledBorder,
    this.maxLines = 1,
    this.border,
    this.validator,
    this.suffixIcon,
    this.obscureText = false,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.white
      ),
      textAlign: textAlign  ?? TextAlign.left,
      inputFormatters: inputFormatter,
      keyboardType: keyboardType,
      enabled: enabled!,
      maxLines: maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      obscureText: obscureText!,
      controller: controller,
      decoration: InputDecoration(
        errorStyle: GoogleFonts.cairo(
          height: 0.5.sp
        ),

        contentPadding: EdgeInsets.symmetric(
          horizontal: 10.sp,
          vertical: 12.sp,
        ),
        isCollapsed: true,
        disabledBorder: disabledBorder,
        border: border ?? OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.sp)
        ),
        suffixIcon: suffixIcon,
        hintText: hintText,
      ),
    );
  }
}
