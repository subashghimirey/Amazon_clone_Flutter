import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  const Stars({super.key, required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: Colors.orange,
      ),
      itemCount: 5,
      direction: Axis.horizontal,
      rating: rating.toDouble(),
      itemSize: 20,
    );
  }
}
