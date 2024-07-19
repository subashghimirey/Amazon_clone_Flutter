import 'package:ecommerce_app/account_page/single_product.dart';
import 'package:ecommerce_app/admin_pages/widgets/add_product.dart';
import 'package:ecommerce_app/authentication/api/django_api.dart';
import 'package:ecommerce_app/widgets/loader.dart';
import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

final apiService = DjangoApi();

class _ProductsState extends State<Products> {
  @override
  void initState() {
    super.initState();
    getProductData();
  }

  List<Map<String, dynamic>>? products;
  String? selectedCategory;

  void getProductData() async {
    // get products from the server
    final response = await apiService.getProducts(category:  selectedCategory);
    setState(() {
      products = response;
    });
    // print(products);
  }

  void deleteProduct(int productId) async {
    try {
      await apiService.deleteProduct(productId);
      setState(() {
        products!.removeWhere((product) => product['id'] == productId);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: products == null
          ? const Loader()
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
                      SizedBox(
                          height: 150,
                          child: SingleProduct(image: product['images'][0])),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                product['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  deleteProduct(product['id']);
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.cyan[500],
          tooltip: "Add a Product",
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddProduct(),
            ));
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
