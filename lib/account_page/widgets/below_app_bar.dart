import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/authentication/api/django_api.dart';
import 'package:flutter/material.dart';

class BelowAppBar extends StatefulWidget {
  const BelowAppBar({super.key});

  @override
  State<BelowAppBar> createState() => _BelowAppBarState();
}

class _BelowAppBarState extends State<BelowAppBar> {
  final apiService = DjangoApi();

  String? username;

  void getUsername() async {
    var user = await apiService.getUsername();
    setState(() {
      username = user;
      // print("here");
      // print(username);
    });
  }

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: GlobalVariables.appBarGradient,
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Hello, ",
                style: TextStyle(fontSize: 25, color: Colors.black),
              ),
            ),
            Text(
              username ?? '',
              style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
