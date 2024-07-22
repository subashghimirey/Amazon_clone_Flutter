import 'package:ecommerce_app/authentication/api/django_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartNotifier extends StateNotifier<Map<String, dynamic>?> {
  CartNotifier() : super(null);

  final apiService = DjangoApi();

  Future<void> getCart() async {
    final cartData = await apiService.getCart();
    state = cartData;

    final items = cartData['items'] as List;
    if (cartData['items'][0]['product'] is int) {
      for (var item in items) {
        print(item['product'] is int);
        final productId = item['product'] as int;
        final product = await apiService.getProductById(productId);
        item['product'] = product;
      }
    }
    state = {...state!, 'items': items};
  }

  Future<void> addToCart(Map<String, dynamic> product, int quantity) async {
    await apiService.addToCart(product['id'], quantity);
    await getCart(); // Refresh cart after adding an item
  }
}

final cartNotifierProvider =
    StateNotifierProvider<CartNotifier, Map<String, dynamic>?>(
        (ref) => CartNotifier());
