import 'package:ecommerce_app/account_page/single_product.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:flutter/material.dart';

class Order extends StatelessWidget {
  Order({super.key});

  final List<String> data = [
    "https://img-prod-cms-rt-microsoft-com.akamaized.net/cms/api/am/imageFileData/RW16TLP?ver=5c8b",
    "https://thumbnail.imgbin.com/4/18/16/mobile-phone-case-gadget-mobile-phone-accessories-mobile-phone-communication-device-UitG0kQW_t.jpg",
    "https://img-prod-cms-rt-microsoft-com.akamaized.net/cms/api/am/imageFileData/RW16TLP?ver=5c8b",
    "https://img-prod-cms-rt-microsoft-com.akamaized.net/cms/api/am/imageFileData/RW16TLP?ver=5c8b",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: const Text(
                "Your Orders",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                "See all",
                style: TextStyle(
                    fontSize: 18, color: GlobalVariables.selectedNavBarColor),
              ),
            )
          ],
        ),
        Container(
          height: 170,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(left: 15, top: 20, right: 10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, index) => SingleProduct(image: data[index]),
          ),
        ),
      ],
    );
  }
}
