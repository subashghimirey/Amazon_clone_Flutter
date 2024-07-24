import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartProduct extends ConsumerWidget {
  const CartProduct({super.key, required this.product, required this.quantity});

  final Map<String, dynamic> product;
  final int quantity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void removeCartItem() {
      ref.read(cartNotifierProvider.notifier).removeFromCart(product['id']);
    }

    void increaseQuantity() {
      ref.read(cartNotifierProvider.notifier).addToCart(product, 1);
    }

    void decreaseQuantity() {
      ref.read(cartNotifierProvider.notifier).addToCart(product, -1);
    }

    final image = product['images'][0];

    final stockQuantity = product['quantity'] as double;

    void outOfStock() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No more items in stock"),
          duration: Duration(seconds: 2),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      product['name'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Rs.${product['price'].toString()}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text("Free Shipping Available")),
                  Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text("In Stock",
                          style: TextStyle(color: Colors.cyan))),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blueGrey[200],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: quantity > 1 ? decreaseQuantity : removeCartItem,
                        child: Container(
                          padding: const EdgeInsets.only(left: 5),
                          height: 40,
                          width: 40,
                          child: const Icon(Icons.remove),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 12, top: 2),
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          color: Colors.white,
                        ),
                        width: 40,
                        child: Text(
                          quantity.toString(),
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      InkWell(
                        onTap: stockQuantity > quantity
                            ? increaseQuantity
                            : outOfStock,
                        child: Container(
                          padding: const EdgeInsets.only(left: 0),
                          height: 40,
                          width: 40,
                          child: const Icon(
                            Icons.add,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: removeCartItem,
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
