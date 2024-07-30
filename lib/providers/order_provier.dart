import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_app/authentication/api/django_api.dart';

class OrderNotifier extends StateNotifier<List<Map<String, dynamic>>?> {
  OrderNotifier() : super(null);

  final apiService = DjangoApi();

  Future<void> createOrder(List<Map<String, dynamic>> items, double totalAmount,
      String address) async {
    final orderData = await apiService.createOrder(items, totalAmount, address);
    state = [...?state, orderData];
    await apiService.clearCart();
  }

  Future<void> fetchOrders() async {
    final orders = await apiService.getOrders();
    state = orders.cast<Map<String, dynamic>>();
  }
}

final orderNotifierProvider =
    StateNotifierProvider<OrderNotifier, List<Map<String, dynamic>>?>(
        (ref) => OrderNotifier());
