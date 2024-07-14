import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10),
          alignment: Alignment.topLeft,
          child: const Text(
            "Deal of the day",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
        Image.asset(
          height: 240,
          "assets/images/laptop.png",
          fit: BoxFit.cover,
        ),
        Container(
          padding: const EdgeInsets.only(left: 30),
          alignment: Alignment.topLeft,
          child: const Text(
            "Rs.250,000",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 30),
          alignment: Alignment.topLeft,
          child: const Text(
            "Mac Book Air pro",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Image.network(
                "https://www.apple.com/newsroom/images/product/mac/standard/Apple-MacBook-Air-and-MacBook-Pro-update-graphics-screen-070919_inline.jpg.large.jpg",
                height: 300,
                width: 500,
              ),
              Image.network(
                "https://static-01.daraz.com.np/p/01107bf10c6441bb8ebdf93d8a9e791b.jpg",
                height: 300,
                width: 500,
              ),
              Image.network(
                "https://imageio.forbes.com/specials-images/imageserve/5fb3d1fa8e17f0f68a05b87f/The-new-MacBook-Air-with-M1-processor-/960x0.jpg?format=jpg&width=960",
                height: 300,
                width: 500,
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 20),
          child: Text(
            "See all deals",
            style:
                TextStyle(fontWeight: FontWeight.w700, color: Colors.cyan[800]),
          ),
        )
      ],
    );
  }
}
