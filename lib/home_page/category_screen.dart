import 'package:ecommerce_app/account_page/single_product.dart';
import 'package:ecommerce_app/authentication/api/django_api.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.category});

  final String category;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

final apiService = DjangoApi();
List<Map<String, dynamic>>? products;

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    getProductData();
  }

  void getProductData() async {
    final String category = widget.category;
    final response = await apiService.getProducts(category);
    print(response);
    setState(() {
      products = response;
    });
    print(products);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            title: Text(widget.category),
          ),
        ),
        body: products == null
            ? Text("No products found in ${widget.category}")
            : GridView.builder(
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final product = products![index];

                  return Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        SingleProduct(image: product['images'][0]),
                        Text(
                          product['name'],
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ));
  }
}
