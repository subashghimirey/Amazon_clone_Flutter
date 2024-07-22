import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/authentication/api/django_api.dart';
import 'package:flutter/material.dart';

class AdminServices {
  final DjangoApi apiService = DjangoApi();

  Future<void> sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("dq8k8enle", "qrw9usjv");
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(response.secureUrl);
        // print("images uploaded");
      }

      final product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);

      await apiService.addProduct(product);

      // print("Product added successfully");
    } catch (err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }
  }
}
