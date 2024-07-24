import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/models/address.dart';
import 'package:ecommerce_app/providers/address_provider.dart';
import 'package:ecommerce_app/widgets/auth_gradient_button.dart';
import 'package:ecommerce_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void submitAddress() {
      final userAddress = Address(
        houseNo: houseController.text,
        street: streetController.text,
        city: cityController.text,
        state: stateController.text,
      );

      ref.read(addressNotifierProvider.notifier).createAddress(userAddress);
    }

    final data = ref.watch(addressNotifierProvider);
    print(data);

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
                for (var address in data)
                  CustomTextField(
                    hintText: "Address:",
                    controller: houseController,
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
                    buttonType: "Buy With eSewa",
                    authFunc: submitAddress,
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
