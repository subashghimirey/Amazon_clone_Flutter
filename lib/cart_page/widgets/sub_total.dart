import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubTotal extends ConsumerWidget {
  const SubTotal({super.key, required this.products});

  final List<Map<String, dynamic>> products;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double sum = 0;

    for (var product in products) {
      sum += product['price'] * product['cartQuantity'] as double;
    }

    void _storeSum() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setDouble('sum', sum);
    }

    _storeSum();


    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10),
      child: Row(
        children: [
          const Text(
            "Subtotal: ",
            style: TextStyle(fontSize: 18),
          ),
          Text(
            "Rs. $sum",
            style: const TextStyle(
              fontSize: 22,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
