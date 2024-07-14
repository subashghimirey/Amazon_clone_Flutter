import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CategoriesBox extends StatelessWidget {
  const CategoriesBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        itemCount: GlobalVariables.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 90,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12)
                    .copyWith(top: 12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    GlobalVariables.categoryImages[index]['image'] ?? '',
                    fit: BoxFit.cover,
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
              Text(GlobalVariables.categoryImages[index]['title'] ?? '')
            ],
          );
        },
      ),
    );
  }
}