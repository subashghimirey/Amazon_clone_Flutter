import 'package:ecommerce_app/authentication/api/django_api.dart';
import 'package:ecommerce_app/models/address.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressNotifier extends StateNotifier<List<Address>?> {
  AddressNotifier() : super(null);

  final apiService = DjangoApi();

  Future<void> getAddress() async {
    final addressData = await apiService.getAddress();
    // print(addressData);
    // state = addressData;
  }

  Future<void> createAddress(Address addressData) async {
    await apiService.createAddress(addressData);
    await getAddress(); // Refresh addresses after adding a new one
  }
}

final addressNotifierProvider =
    StateNotifierProvider<AddressNotifier, List<Address>?>(
        (ref) => AddressNotifier());
