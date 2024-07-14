import 'package:ecommerce_app/constants/app_pallete.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.maxLines = 1,
      this.isObscure = false});

  final String hintText;
  final TextEditingController controller;
  final bool isObscure;
  final int maxLines;

  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: _border(),
        focusedBorder: _border(Colors.black),
      ),
      obscureText: isObscure,
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is empty";
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
