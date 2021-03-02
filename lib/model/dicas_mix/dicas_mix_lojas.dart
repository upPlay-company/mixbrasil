import 'package:cloud_firestore/cloud_firestore.dart';

class DicasMixLojas {

  String id;
  String img;

  DicasMixLojas.fromDocument(DocumentSnapshot document){
    id = document.id;
    img = document.data()['img'];
  }

  @override
  String toString() {
    return 'DicasMixLojas{id: $id, img: $img}';
  }
}