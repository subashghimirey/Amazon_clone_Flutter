import 'package:ecommerce_app/constants/app_pallete.dart';
import 'package:ecommerce_app/django_api.dart';
import 'package:ecommerce_app/widgets/auth_field.dart';
import 'package:ecommerce_app/widgets/auth_gradient_button.dart';
import 'package:ecommerce_app/widgets/login_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  final api = DjangoApi();

  @override
  State<SignUpPage> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signup() async {
    try {
      final result = await widget.api.signup(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
      );
      print('Signup successful: $result');
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoginPage(),
      ));
    } catch (err) {
      print('Signup Failed: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
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
                hintText: "Email",
                controller: _emailController,
              ),
              const SizedBox(height: 15),
              AuthField(
                hintText: "Password",
                controller: _passwordController,
                isObscure: true,
              ),
              const SizedBox(height: 15),
              AuthGradientButton(
                buttonType: "Sign Up",
                authFunc: _signup,
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginPage(),
                )),
                child: RichText(
                    text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                      TextSpan(
                          text: "Sign In",
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
