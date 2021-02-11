
class BannersItens {

  BannersItens({this.img, this.estado});

  dynamic img;
  String estado;

  BannersItens.fromMap(Map<String, dynamic> map) {
    img = map['img'] as String;
    estado = map['estado'] as String;
  }

  Map<String, dynamic> toMap(){
    return {
      'img': img,
      'estado': estado
    };
  }

  @override
  String toString() {
    return 'BannersItens{img: $img, estado: $estado}';
  }
}