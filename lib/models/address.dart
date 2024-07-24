class Address {
  final String houseNo;
  final String street;
  final String city;
  final String state;

  Address({
    required this.houseNo,
    required this.street,
    required this.city,
    required this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      houseNo: json['house_no'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'house_no': houseNo,
      'street': street,
      'city': city,
      'state': state,
    };
  }
}
