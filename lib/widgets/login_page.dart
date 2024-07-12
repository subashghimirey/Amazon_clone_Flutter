import 'package:ecommerce_app/constants/app_pallete.dart';
import 'package:ecommerce_app/django_api.dart';
import 'package:ecommerce_app/home_page.dart.dart';
import 'package:ecommerce_app/widgets/auth_field.dart';
import 'package:ecommerce_app/widgets/auth_gradient_button.dart';
import 'package:ecommerce_app/widgets/bottom_nav_bar.dart';
import 'package:ecommerce_app/widgets/signup_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }

  final api = DjangoApi();

  static route() => MaterialPageRoute(
        builder: (context) => LoginPage(),
      );
}

var isLoggedIn = false;

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _token = '';

  Future<void> _login() async {
    try {
      final result = await widget.api.login(
        _usernameController.text,
        _passwordController.text,
      );
      setState(() {
        _token = result['token'];
        isLoggedIn = true;
      });
      // print('Login successful: Token $_token');
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const BottomNavBar(),
      ));
    } catch (err) {
      print('Login failed: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 200, 200, 200),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              AuthField(
                hintText: "Username",
                controller: _usernameController,
              ),
              const SizedBox(height: 15),
              AuthField(
                hintText: "Password",
                controller: _passwordController,
                isObscure: true,
              ),
              const SizedBox(height: 15),
              AuthGradientButton(
                buttonType: "Sign In",
                authFunc: _login,
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SignUpPage(),
                )),
                child: RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                      TextSpan(
                          text: "Sign Up",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.bold)),
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
