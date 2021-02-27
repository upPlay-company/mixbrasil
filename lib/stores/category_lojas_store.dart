import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mix_brasil/model/categorias/categorias.dart';
import 'package:mobx/mobx.dart';

part 'category_lojas_store.g.dart';

class CategoryLojasStore = _CategoryLojasStore with _$CategoryLojasStore;

abstract class _CategoryLojasStore with Store {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  _CategoryLojasStore(){
    _loadCategoriesLojas();
  }

  ObservableList<Categorias> categoryList = ObservableList<Categorias>();

  @action
  void setCategories(List<Categorias> categories) {
    categoryList.clear();
    categoryList.addAll(categories);
  }

  @observable
  String error;

  @computed
  List<Categorias> get allDesapegoCategoryList =>
      List.from(categoryList)..insert(0, Categorias(id: '*', name: 'Todas'));

  @action
  void setError(String value) => error = value;

  Future<void> _loadCategoriesLojas() async {
    try {
      final queryBuilder = firestore.collection('categorias').get();

      final response = await queryBuilder;

      final categories = response.docs.map((e) =>
          Categorias.fromDocument(e)).toList();

      setCategories(categories);
    } catch (e){
      setError(e);
    }
  }

}