import 'package:ecommerce_app/authentication/api/django_api.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/home_page/search_screen.dart';
import 'package:ecommerce_app/home_page/widgets/stars.dart';
import 'package:ecommerce_app/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

final apiService = DjangoApi();

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController _reviewController = TextEditingController();

  double _rating = 3.0;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onSearch() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            SearchScreen(searchQuery: searchController.text)));
  }

  Future<void> _submitRating() async {
    final String review = "good";

    try {
      print({widget.product['id']});
      await apiService.addRating(widget.product['id'], _rating.toInt(), review);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rating submitted successfully!')),
      );
      print("success");
      _reviewController.clear();
      setState(() {
        _rating = 0.0; // Reset to initial rating
      });
    } catch (e) {
      print("here some error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting rating: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 10).copyWith(left: 55),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Material(
                          borderRadius: BorderRadius.circular(8),
                          elevation: 1,
                          child: Form(
                            child: TextFormField(
                              controller: searchController,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    value.isEmpty) {
                                  return null;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                prefixIcon: InkWell(
                                  onTap: onSearch,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(top: 10),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black38,
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.black38,
                                    width: 1,
                                  ),
                                ),
                                hintText: "Search Amazon",
                                hintStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: const Icon(
                          Icons.mic,
                          size: 28,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        widget.product["name"],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(right: 20),
                        alignment: Alignment.topRight,
                        child: const Stars(rating: 4)),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Image.network(
                    widget.product["images"][0],
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  color: Colors.black12,
                  height: 5,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const Text(
                        "Deal Price: ",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Rs.${widget.product["price"].toString()}",
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 243, 150, 12)),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    widget.product["description"],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  color: Colors.black12,
                  height: 5,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AuthGradientButton(
                      buttonType: "Buy Now",
                      color1: Colors.orange,
                      color2: Colors.deepOrange,
                      authFunc: () {}),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: AuthGradientButton(
                      buttonType: "Add to Cart",
                      color1: Color.fromARGB(255, 100, 146, 65),
                      color2: Color.fromARGB(255, 60, 197, 126),
                      authFunc: () {}),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: const Text(
                    "Rate the Product",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                RatingBar.builder(
                  initialRating: _rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 50,
                  itemPadding:
                      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  onRatingUpdate: (rating) {
                    setState(() {
                      _rating = rating;
                    });
                  },
                ),
                TextButton(onPressed: _submitRating, child: Text("Submit"))
              ],
            ),
          ),
        ));
  }
}
