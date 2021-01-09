class Address {

  Address({this.street, this.district, this.zipCode, this.city, this.state, this.lat, this.long});

  String street;
  String district;
  String zipCode;
  String city;
  String state;

  double lat;
  double long;

  Address.fromMap(Map<String, dynamic> map){
    street = map['street'] as String;
    district = map['district'] as String;
    zipCode = map['zipCode'] as String;
    city = map['city'] as String;
    state = map['state'] as String;
    lat = map['lat'] as double;
    long = map['long'] as double;
  }

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'district': district,
      'zipCode': zipCode,
      'city': city,
      'state': state,
      'lat': lat,
      'long': long,
    };
  }

}