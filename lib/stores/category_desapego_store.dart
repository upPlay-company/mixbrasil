import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mix_brasil/model/desapego/desapego_category.dart';
import 'package:mobx/mobx.dart';

part 'category_desapego_store.g.dart';

class CategoryDesapegoStore = _CategoryDesapegoStore with _$CategoryDesapegoStore;

abstract class _CategoryDesapegoStore with Store {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  _CategoryDesapegoStore(){
    _loadCategoriesDesapego();
  }

  ObservableList<DesapegoCategory> categoryList = ObservableList<DesapegoCategory>();

  @action
  void setCategories(List<DesapegoCategory> categories) {
    categoryList.clear();
    categoryList.addAll(categories);
  }

  @observable
  String error;

  @computed
  List<DesapegoCategory> get allDesapegoCategoryList =>
      List.from(categoryList)..insert(0, DesapegoCategory(id: '*', name: 'Todas'));

  @action
  void setError(String value) => error = value;

  Future<void> _loadCategoriesDesapego() async {
   try {
     final queryBuilder = firestore.collection('desapego').get();

     final response = await queryBuilder;

     final categories = response.docs.map((e) =>
         DesapegoCategory.fromDocument(e)).toList();

     setCategories(categories);
   } catch (e){
     setError(e);
   }
  }

}