import 'package:ecommerce_app/authentication/api/django_api.dart';
import 'package:ecommerce_app/product_details/product_detail_screen.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

final apiService = DjangoApi();

class _DealOfDayState extends State<DealOfDay> {
  Map<String, dynamic>? dealOfDay;
  List<Map<String, dynamic>> products = [];

  void getDealOfDay() async {
    final deal = await apiService.getDealOfTheDay();
    setState(() {
      if (deal.isEmpty) {
        dealOfDay = products.isNotEmpty ? products[0] : null;
      } else {
        dealOfDay = deal;
      }
    });
    print("$dealOfDay");
  }

  void getProducts() async {
    products = await apiService.getProducts();
  }

  @override
  void initState() {
    super.initState();
    getDealOfDay();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return dealOfDay == null
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,
                child: const Text(
                  "Deal of the day",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (dealOfDay != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: dealOfDay!,
                        ),
                      ),
                    );
                  }
                },
                child: dealOfDay != null &&
                        dealOfDay!['images'] != null &&
                        dealOfDay!['images'].isNotEmpty
                    ? Image.network(
                        dealOfDay!['images'][0],
                        height: 300,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 300,
                        color: Colors.grey[200],
                        child: Center(
                          child: Text('No image available'),
                        ),
                      ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, top: 5),
                alignment: Alignment.topLeft,
                child: dealOfDay != null
                    ? Text(
                        dealOfDay!['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : Container(),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.topLeft,
                child: dealOfDay != null
                    ? Text(
                        dealOfDay!['price'].toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      )
                    : Container(),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: dealOfDay != null && dealOfDay!['images'] != null
                      ? dealOfDay!['images']
                          .map<Widget>(
                            (image) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Image.network(
                                image,
                                height: 300,
                                width: 400,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                          .toList()
                      : [Container()],
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding:
                    const EdgeInsets.symmetric(vertical: 15).copyWith(left: 20),
                child: Text(
                  "See all deals",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.cyan[800]),
                ),
              )
            ],
          );
  }
}
