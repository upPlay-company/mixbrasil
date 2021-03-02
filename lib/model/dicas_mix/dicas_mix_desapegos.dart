import 'package:cloud_firestore/cloud_firestore.dart';

class DicasMixDesapegos {

  String id;
  String img;

  DicasMixDesapegos.fromDocument(DocumentSnapshot document){
    id = document.id;
    img = document.data()['img'];
  }

  @override
  String toString() {
    return 'DicasMixLojas{id: $id, img: $img}';
  }
}