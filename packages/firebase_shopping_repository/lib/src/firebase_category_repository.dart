import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shopping_repository_interface/shopping_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCategoryRepository implements CategoryRepositoryInterface {
  FirebaseCategoryRepository({
    this.collectionName = 'shopping_category',
  });

  final String collectionName;

  final StreamController<List<Category>> _categoryController =
      BehaviorSubject<List<Category>>();
  final StreamController<List<Category>> _selectedCategoriesController =
      BehaviorSubject<List<Category>>();
  List<Category> _selectedCategories = [];
  List<Category> _categories = [];

  @override
  void deselectCategory(String? categoryId) {
    _selectedCategories.removeWhere((category) => category.id == categoryId);
    _selectedCategoriesController.add(_selectedCategories);
  }

  @override
  Stream<List<Category>> getCategories() {
    FirebaseFirestore.instance
        .collection(collectionName)
        .snapshots()
        .listen((event) {
      List<Category> categories = [];
      event.docs.forEach((element) {
        categories.add(Category.fromMap(element.id, element.data()));
      });
      _categoryController.add(categories);
      _categories = categories;
    });

    return _categoryController.stream;
  }

  @override
  Stream<List<Category>?> getSelectedCategoryStream() {
    _selectedCategoriesController.add(_selectedCategories);
    return _selectedCategoriesController.stream;
  }

  @override
  Category? selectCategory(String? categoryId) {
    _selectedCategories
        .add(_categories.firstWhere((category) => category.id == categoryId));
    _selectedCategoriesController.add(_selectedCategories);
    return _selectedCategories.last;
  }
}
