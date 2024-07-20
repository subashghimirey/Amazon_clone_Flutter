import 'package:ecommerce_app/authentication/api/django_api.dart';
import 'package:ecommerce_app/cart_page/cart_page.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/home_page/home_page.dart.dart';
import 'package:ecommerce_app/account_page/account_page.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() {
    return _BottomNavBarState();
  }
}

final apiService = DjangoApi();

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  Map<String, dynamic>? cart;

  List<Widget> pages = [];

  void _updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  void getCart() async {
    final cartData = await apiService.getCart();
    setState(() {
      cart = cartData;
    });
    print(cartData);
  }

  void updateCart() {
    getCart();
  }

  @override
  void initState() {
    super.initState();
    pages = [
      HomePage(),
      const AccountPage(),
      const CartPage(),
    ];
    getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: GlobalVariables.backgroundColor,
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        iconSize: 30,
        onTap: _updatePage,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 0
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: bottomBarBorderWidth))),
              child: const Icon(Icons.home),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 1
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor,
                            width: bottomBarBorderWidth))),
                child: const Icon(Icons.person_2_outlined),
              ),
              label: ''),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 2
                              ? GlobalVariables.selectedNavBarColor
                              : GlobalVariables.backgroundColor,
                          width: bottomBarBorderWidth))),
              child: Badge(
                label:
                    Text(cart != null ? cart!['items'].length.toString() : '0'),
                backgroundColor: GlobalVariables.backgroundColor,
                // padding: EdgeInsets.all(2),
                textColor: Colors.black,
                textStyle:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                child: const Icon(Icons.shopping_cart),
              ),
            ),
            label: '',
          )
        ],
      ),
    );
  }
}
