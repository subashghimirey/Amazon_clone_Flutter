import 'package:ecommerce_app/account_page/widgets/below_app_bar.dart';
import 'package:ecommerce_app/account_page/widgets/buttons.dart';
import 'package:ecommerce_app/account_page/widgets/order.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
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
          )),
      body: Column(
        children: [
          const BelowAppBar(),
          Buttons(),
          const SizedBox(
            height: 10,
          ),
          Order(),
        ],
      ),
    );
  }
}
