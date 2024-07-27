import 'package:ecommerce_app/authentication/pages/login_page.dart';
import 'package:ecommerce_app/constants/theme.dart';
import 'package:ecommerce_app/authentication/api/django_api.dart';
import 'package:ecommerce_app/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final apiService = DjangoApi();
  Future<String?>? _userTypeFuture;

  @override
  void initState() {
    super.initState();
    getUserType();
  }

  String userType = "";

  void getUserType() async {
    final type = await apiService.getUserType();
    setState(() {
      userType = type ?? "";
    });
    // print(userType);
  }

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
        publicKey: "test_public_key_2c4f041f440e47a5a1c2ef3a30da8f5e",
        builder: (context, navigatorKey) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightThemeMode,
            home: FutureBuilder<String?>(
              future: apiService.getToken(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  if (snapshot.hasData && snapshot.data != null) {
                    return FutureBuilder(
                      future: apiService.getUserType(),
                      builder: (context, snapshot) {
                        if (userType == "normal") {
                          // return const AdminHome();
                          return const BottomNavBar();
                        } else {
                          // return const AdminHome();
                          return const BottomNavBar();
                        }
                      },
                    );
                  } else {
                    return LoginPage();
                    // return const BottomNavBar();
                    // return const AdminHome();
                  }
                }
              },
            ),
          );
        });
  }
}
