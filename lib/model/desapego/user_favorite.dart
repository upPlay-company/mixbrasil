class FavoriteUser {

  FavoriteUser({this.favoriteId});

  FavoriteUser.fromMap(Map<String, dynamic> map){
    favoriteId = map['favoriteId'] as String;
  }

  // ignore: non_constant_identifier_names
  String favoriteId;
}