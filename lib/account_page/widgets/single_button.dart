
import 'package:flutter/material.dart';

class SingleButton extends StatelessWidget {
  const SingleButton({super.key, required this.buttonType, required this.onTap});

  final String buttonType;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(108, 140, 226, 218),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5)),
          child: Text(
            buttonType,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
