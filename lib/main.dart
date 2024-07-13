import 'package:ecommerce_app/constants/theme.dart';
import 'package:ecommerce_app/authentication/api/django_api.dart';
import 'package:ecommerce_app/widgets/bottom_nav_bar.dart';
// import 'package:ecommerce_app/authentication/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final apiService = DjangoApi();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeMode,
      home: FutureBuilder<String?>(
        future: apiService.getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              return const BottomNavBar();
            } else {
              // return LoginPage();
              return const BottomNavBar();
            }
          }
        },
      ),
    );
  }
}
