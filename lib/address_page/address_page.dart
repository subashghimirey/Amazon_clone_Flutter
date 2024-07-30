import 'package:ecommerce_app/account_page/account_page.dart';
import 'package:ecommerce_app/account_page/widgets/order.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/providers/address_provider.dart';
import 'package:ecommerce_app/providers/order_provier.dart';
import 'package:ecommerce_app/widgets/auth_gradient_button.dart';
import 'package:ecommerce_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressPage extends ConsumerStatefulWidget {
  const AddressPage({super.key});

  @override
  ConsumerState<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends ConsumerState<AddressPage> {
  TextEditingController houseController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  int amount = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _getStoredSum();
    ref.read(addressNotifierProvider.notifier).getAddress();
  }

  Future<void> _getStoredSum() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? storedSum = prefs.getDouble('sum');
    print(storedSum);
    if (storedSum != null) {
      setState(() {
        amount = storedSum.toInt();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String addressToBeUsed = "";

    void submitAddress() {
      ref.read(addressNotifierProvider.notifier).createAddress(
            stateController.text,
            cityController.text,
            streetController.text,
            houseController.text,
          );
    }

    final data = ref.watch(addressNotifierProvider);
    int length = 0;
    if (data != null) {
      length = data.length;
    }

    final config = PaymentConfig(
      amount: amount > 20000 ? 19900 : amount,
      productIdentity: "test id",
      productName: "test product",
    );

    void onSuccess(PaymentSuccessModel success) async {
      print("Payment Success");
      print(success);

      List<Map<String, dynamic>> items =
          []; // Populate this with the actual cart items

      await ref.read(orderNotifierProvider.notifier).createOrder(
            items,
            amount.toDouble(),
            addressToBeUsed,
          );

      print("Order created and cart cleared");

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const AccountPage(),
      ));
    }

    void onFailure(PaymentFailureModel failure) {
      print("Payment Failure");
      print(failure);
    }

    void onPay() {
      KhaltiScope.of(context)
          .pay(config: config, onSuccess: onSuccess, onFailure: onFailure);
    }

    void onPressed() {
      bool isForm = stateController.text.isNotEmpty ||
          cityController.text.isNotEmpty ||
          streetController.text.isNotEmpty ||
          houseController.text.isNotEmpty;

      if (isForm) {
        if (_formKey.currentState!.validate()) {
          submitAddress();
          addressToBeUsed =
              "Address: ${stateController.text}, ${cityController.text}, ${streetController.text}, ${houseController.text}";
        } else {
          throw Exception("Please enter all data");
        }
      } else if (data != null) {
        addressToBeUsed =
            "Address: ${data[length - 1]['states']}, ${data[length - 1]['city']}, ${data[length - 1]['street']}, ${data[length - 1]['house_no']}";
      } else {
        throw Exception("Error!");
      }

      onPay();
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text("Address Page"),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (data != null)
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Address: ${data[length - 1]['states']}, ${data[length - 1]['city']}, ${data[length - 1]['street']}, ${data[length - 1]['house_no']},",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              if (data != null)
                const Text(
                  "OR",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              if (data != null)
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              Column(
                children: [
                  CustomTextField(
                      hintText: "State", controller: stateController),
                  const SizedBox(height: 10),
                  CustomTextField(hintText: "City", controller: cityController),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: "Area, Street",
                    controller: streetController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: "Flat, House no, Building",
                    controller: houseController,
                  ),
                  const SizedBox(height: 20),
                  AuthGradientButton(
                    buttonType: "Pay With Khalti",
                    authFunc: onPressed,
                    color1: const Color.fromARGB(255, 94, 228, 94),
                    color2: const Color.fromARGB(255, 49, 203, 38),
                    textColor: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
