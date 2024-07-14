import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map(
        (i) {
          return Builder(builder: (BuildContext context) {
            return Image.network(
              i,
              fit: BoxFit.cover,
              width: double.infinity,
            );
          });
        },
      ).toList(),
      options: CarouselOptions(
        height: 240,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
      ),
    );
  }
}
