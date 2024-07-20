import 'package:ecommerce_app/authentication/api/django_api.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/home_page/search_screen.dart';
import 'package:ecommerce_app/home_page/widgets/address_box.dart';
import 'package:ecommerce_app/home_page/widgets/carousel_image.dart';
import 'package:ecommerce_app/home_page/widgets/categories_box.dart';
import 'package:ecommerce_app/home_page/widgets/deal_of_day.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  final apiService = DjangoApi();

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                        child: TextFormField(
                          controller: searchController,
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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            AddressBox(),
            CategoriesBox(),
            CarouselImage(),
            SizedBox(height: 10),
            DealOfDay(),
          ],
        ),
      ),
    );
  }
}
