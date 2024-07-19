import 'package:ecommerce_app/constants/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  const AuthGradientButton({
    super.key,
    required this.buttonType,
    required this.authFunc,
    color1,
    color2,
  })  : color1 = color1 ?? AppPallete.gradient1,
        color2 = color2 ?? AppPallete.gradient2;

  final String buttonType;
  final void Function() authFunc;
  final Color color1;
  final Color color2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color1,
              color2,
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
