import 'package:ecommerce_app/account_page/widgets/single_button.dart';
import 'package:ecommerce_app/authentication/api/django_api.dart';
import 'package:ecommerce_app/authentication/pages/login_page.dart';
import 'package:flutter/material.dart';

class Buttons extends StatefulWidget {
  Buttons({super.key});
  final apiService = DjangoApi();

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  String _token = '';

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final token = await widget.apiService.getToken();
    setState(() {
      _token = token ?? '';
    });
  }

  Future<void> _logout() async {
    try {
      await widget.apiService.logout();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      // print('Logout successful');
    } catch (e) {
      // print(e);
      throw Exception("Some error occured, have patience");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleButton(
                buttonType: "Your Orders",
                onTap: () {},
              ),
              SingleButton(
                buttonType: "Become Seller",
                onTap: () {},
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleButton(
                buttonType: "Your Wish List",
                onTap: () {},
              ),
              SingleButton(
                buttonType: "Log Out",
                onTap: _logout,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
