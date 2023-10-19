class AddressModel {
  final String id;
  final String address;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final String phone;

  AddressModel({
    required this.id,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
      'phone': phone,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      postalCode: map['postalCode'] as String,
      phone: map['phone'] as String,
    );
  }
}
