import 'package:ecommerce_app/django_api.dart';
import 'package:ecommerce_app/widgets/login_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final apiService = DjangoApi();

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
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
      print('Logout successful');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _logout,
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
