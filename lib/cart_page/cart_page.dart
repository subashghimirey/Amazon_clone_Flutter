import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  void initState() {
    super.initState();
    ref.read(cartNotifierProvider.notifier).getCart();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartNotifierProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  height: 50,
                  width: 130,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10),
                child: const Row(children: [
                  Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.notifications_active)),
                  Icon(Icons.search)
                ]),
              )
            ],
          ),
        ),
      ),
      body: cart == null
          ? const Center(
              child: Text("No items in cart, Add some"),
            )
          : ListView.builder(
              itemCount: cart['items'].length,
              itemBuilder: (context, index) {
                final cartItem = cart['items'][index];
                final product = cartItem['product'];
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: Image.network(
                              product['images'][0],
                            ).image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product['name']),
                          Text("Rs. ${product['price']}"),
                          Text("Quantity: ${cart['items'][index]['quantity']}"),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
