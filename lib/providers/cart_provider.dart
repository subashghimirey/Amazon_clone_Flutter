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
    await apiService.addToCart(product['id'], quantity);
    await getCart(); // Refresh cart after adding an item
  }

  Future<void> removeFromCart(int productId) async {
    await apiService.removeFromCart(productId);
    await getCart(); // Refresh cart after removing an item
  }
}

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, Map<String, dynamic>?>(
        (ref) => CartNotifier());
