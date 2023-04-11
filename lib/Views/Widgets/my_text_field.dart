import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final OutlineInputBorder? border;
  final Widget? suffixIcon;
  final int maxLines;
  final bool? obscureText;
  final bool? enabled;

  final OutlineInputBorder? disabledBorder;
  final String? Function(String?)? validator;

  const MyTextField({
    Key? key,

    this.enabled = true,
    this.disabledBorder,
    this.maxLines = 1,
    this.border,
    this.validator,
    this.suffixIcon,
    this.obscureText= false,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      maxLines: maxLines,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      obscureText: obscureText!,
      controller: controller,
      decoration:InputDecoration(

        disabledBorder: disabledBorder,
        border: border,
        suffixIcon: suffixIcon,
        hintText: hintText,
      ),
    );
  }
}
