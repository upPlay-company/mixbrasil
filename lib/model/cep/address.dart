import 'package:mix_brasil/model/cep/uf.dart';

import 'city.dart';

class Address {

  Address({this.district, this.zipCode, this.city, this.state, this.lat, this.long, this.cidade, this.uf});

  String district;
  String zipCode;
  String city;
  String state;
  double lat;
  double long;

  UF uf;
  City cidade;

  Address.fromMap(Map<String, dynamic> map){
    district = map['district'] as String;
    zipCode = map['zipCode'] as String;
    city = map['city'];
    state = map['state'];
    lat = map['lat'] as double;
    long = map['long'] as double;
  }

  Map<String, dynamic> toMap() {
    return {
      'district': district,
      'zipCode': zipCode,
      'city': city,
      'state': state,
      'lat': lat,
      'long': long,
    };
  }

  @override
  String toString() {
    return 'Address{district: $district, zipCode: $zipCode, city: $city, state: $state, lat: $lat, long: $long, uf: $uf, cidade: $cidade}';
  }
}