import 'package:ecommerce_app/home_page/widgets/stars.dart';
import 'package:ecommerce_app/product_details/product_detail_screen.dart';
import 'package:flutter/material.dart';

class SearchedItem extends StatelessWidget {
  const SearchedItem({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              product: product,
            ),
          ));
        },
        child: Row(
          children: [
            Image.network(
              product["images"][0],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product["name"],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Stars(rating: 4),
                const SizedBox(height: 5),
                Text(
                  "Rs.${product["price"].toString()}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "FREE Shipping available",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const Text(
                  "In Stock",
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
