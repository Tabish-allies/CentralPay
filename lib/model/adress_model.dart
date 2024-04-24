class AddressModel {
  String addressName;
  String id;
  String houseNumber;
  String street;
  String city;
  String state;
  String postalCode;
  String country;
  String phoneNumber;

  AddressModel({
    required this.addressName,
    required this.id,
    required this.houseNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.phoneNumber,
  });

  // from map
  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      addressName: map['address name'] ?? '',
      id: map['id'] ?? '',
      houseNumber: map['house number'] ?? '',
      street: map['street'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      postalCode: map['postalCode'] ?? '',
      country: map['country'] ?? '',
      phoneNumber: map['phone number'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "address name":addressName,
      "house number" : houseNumber,
      "id": id,
      "street": street,
      "city": city,
      "state": state,
      "postalCode": postalCode,
      "country": country,
      "phone number":phoneNumber,
    };
  }
}