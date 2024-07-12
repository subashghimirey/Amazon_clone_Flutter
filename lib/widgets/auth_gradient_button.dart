import 'package:ecommerce_app/constants/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  const AuthGradientButton({super.key, required this.buttonType, required this.authFunc});

  final String buttonType;
  final void Function() authFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppPallete.gradient1,
              AppPallete.gradient2,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        onPressed: authFunc,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(420, 60),
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
        ),
        child: Text(
          buttonType,
          style: const TextStyle(color: AppPallete.whiteColor, fontSize: 18),
        ),
      ),
    );
  }
}
