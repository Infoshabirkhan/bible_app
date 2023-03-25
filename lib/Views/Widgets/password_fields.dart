import 'package:bible_app/Views/Widgets/my_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordFields extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;

  final String? Function(String?)? validator;

  const PasswordFields({
    Key? key,
    this.validator,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  State<PasswordFields> createState() => _PasswordFieldsState();
}

class _PasswordFieldsState extends State<PasswordFields> {
  bool dontShow = true;

  @override
  Widget build(BuildContext context) {
    return MyTextField(
      validator:  widget.validator,
      controller: widget.controller,
      hintText: widget.hintText,
      suffixIcon: IconButton(
        onPressed: () {
          dontShow = !dontShow;
          setState(() {

          });
        },
        icon: Icon(!dontShow ? Icons.visibility_off: Icons.visibility),
      ),
      obscureText: dontShow,
    );
  }
}
