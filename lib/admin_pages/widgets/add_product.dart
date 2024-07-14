import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_app/constants/global_variables.dart';
import 'package:ecommerce_app/widgets/auth_gradient_button.dart';
import 'package:ecommerce_app/widgets/custom_text_Field.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/utils.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

List<String> categories = [
  'Mobiles',
  'Essentials',
  'Appliances',
  'Books',
  'Fashion',
];

String categoryValue = 'Books';

List<File> images = [];

class _AddProductState extends State<AddProduct> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  void _selectImages() async {
    final result = await pickImages();
    setState(() {
      images = result;
    });
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Container(
            padding: const EdgeInsets.only(right: 40, top: 10),
            alignment: Alignment.center,
            child: const Text(
              "Add Product",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              images.isNotEmpty
                  ? CarouselSlider(
                      items: images.map(
                        (image) {
                          return Builder(
                              builder: (BuildContext context) =>
                                  Image.file(image));
                        },
                      ).toList(),
                      options: CarouselOptions(
                        autoPlayInterval: const Duration(seconds: 2),
                        height: 200,
                        autoPlay: true,
                      ))
                  : GestureDetector(
                      onTap: _selectImages,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [8, 4],
                        // strokeCap: StrokeCap.round,
                        strokeWidth: 1.5,
                        child: const SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              Text(
                                "Select Product images",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  hintText: "Product Name", controller: _productNameController),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                  hintText: "Description",
                  maxLines: 8,
                  controller: _descriptionController),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                hintText: "Price",
                controller: _priceController,
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                hintText: "Quantity",
                controller: _quantityController,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton(
                    dropdownColor: Colors.white,
                    alignment: Alignment.center,
                    value: categoryValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    items: categories.map((String category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(
                          category,
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.7)),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(
                        () {
                          categoryValue = value!;
                        },
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              AuthGradientButton(buttonType: "Add Product", authFunc: () {})
            ],
          ),
        )),
      ),
    );
  }
}
