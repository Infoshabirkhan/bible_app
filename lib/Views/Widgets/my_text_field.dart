import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;

  const MyTextField({
    Key? key,
    this.validator,
    this.suffixIcon,
    this.obscureText= false,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      obscureText: obscureText!,
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
      ),
    );
  }
}
