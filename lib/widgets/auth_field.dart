import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isObscure = false});

  final String hintText;
  final TextEditingController controller;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: isObscure,
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is empty";
        }
        return null;
      },
    );
  }
}
