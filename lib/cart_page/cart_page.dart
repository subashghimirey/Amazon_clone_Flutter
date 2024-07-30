import 'package:ecommerce_app/address_page/address_page.dart';
import 'package:ecommerce_app/cart_page/widgets/cart_product.dart';
import 'package:ecommerce_app/cart_page/widgets/sub_total.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/home_page/category_screen.dart';
import 'package:ecommerce_app/home_page/widgets/address_box.dart';
import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/widgets/auth_gradient_button.dart';
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

    int cartLength =
        cart!['products'] == null ? 0 : cart['products'].length;

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
      body: cart['products'] == null
          ? const Center(
              child: Text("No Products in Cart!"),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const AddressBox(),
                  SubTotal(
                    products: cart['products'],
                  ),
                  
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: AuthGradientButton(
                        buttonType: "Proceed to Buy ($cartLength)",
                        color1: const Color.fromARGB(255, 235, 214, 28),
                        color2: const Color.fromARGB(255, 235, 214, 28),
                        textColor: Colors.black,
                        authFunc: cartLength > 0 ? () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddressPage(),
                          ));
                        } : (){},
                      ),
                    ),
                  Container(
                    height: MediaQuery.of(context).size.height *
                        0.6, // Set a fixed height
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cart['products'].length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> product = cart['products'][index];
                        int quantity = product['cartQuantity'];

                        return CartProduct(
                            product: product, quantity: quantity);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
