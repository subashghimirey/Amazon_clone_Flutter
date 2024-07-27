import 'package:ecommerce_app/authentication/api/django_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends StateNotifier<Map<String, dynamic>?> {
  CartNotifier() : super(null);

  final apiService = DjangoApi();

  Future<void> getCart() async {
    final cartData = await apiService.getCart();
    state = cartData;

    List<Map<String, dynamic>> products = [];

    final items = cartData['items'] as List;
    for (var item in items) {
      if (item['product'] is int) {
        final productId = item['product'] as int;
        final product = await apiService.getProductById(productId);
        product.addAll({"cartQuantity": item['quantity']});
        products.add(product);
        // products.add({"cartQuantity": item['quantity']});
        item['product'] = product;
      }
    }
    state = {'products': products};
  }

  Future<void> addToCart(Map<String, dynamic> product, int quantity) async {
    // Update state optimistically
    final updatedCart = {...?state};
    final updatedProducts =
        List<Map<String, dynamic>>.from(updatedCart['products'] ?? []);

    final existingProductIndex =
        updatedProducts.indexWhere((p) => p['id'] == product['id']);
    if (existingProductIndex != -1) {
      updatedProducts[existingProductIndex]['cartQuantity'] += quantity;
    } else {
      updatedProducts.add({...product, 'cartQuantity': quantity});
    }

    updatedCart['products'] = updatedProducts;
    state = updatedCart;

    // Send request to backend
    await apiService.addToCart(product['id'], quantity);

    // Fetch the latest cart data to ensure consistency
    // await getCart();
  }

  Future<void> removeFromCart(int productId) async {
    // Update state optimistically
    final updatedCart = {...?state};
    final updatedProducts =
        List<Map<String, dynamic>>.from(updatedCart['products'] ?? []);

    final existingProductIndex =
        updatedProducts.indexWhere((p) => p['id'] == productId);
    if (existingProductIndex != -1) {
      updatedProducts.removeAt(existingProductIndex);
    }

    updatedCart['products'] = updatedProducts;
    state = updatedCart;

    // Send request to backend
    await apiService.removeFromCart(productId);

    // Fetch the latest cart data to ensure consistency
    // await getCart();
  }
}

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, Map<String, dynamic>?>(
        (ref) => CartNotifier());
