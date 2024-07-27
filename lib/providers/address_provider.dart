import 'package:ecommerce_app/authentication/api/django_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressNotifier extends StateNotifier<List<Map<String, dynamic>>?> {
  AddressNotifier() : super(null);

  final apiService = DjangoApi();

  Future<void> getAddress() async {
    final addressData = await apiService.getAddress();
    state = addressData;
  }

  Future<void> createAddress(
      String states, String city, String street, String house) async {
    await apiService.createAddress(states, city, street, house);

    final newAddress = {
      "states": states,
      "city": city,
      "street": street,
      "house_no": house
    };

    // Directly update the state by adding the new address
    state = [...?state, newAddress];
  }
}

final addressNotifierProvider =
    StateNotifierProvider<AddressNotifier, List<Map<String, dynamic>>?>(
        (ref) => AddressNotifier());
