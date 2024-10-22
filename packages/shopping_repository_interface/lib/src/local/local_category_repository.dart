import "dart:async";

import "package:collection/collection.dart";
import "package:rxdart/rxdart.dart";
import "package:shopping_repository_interface/src/interfaces/category_repository_interface.dart";
import "package:shopping_repository_interface/src/models/category.dart";

/// The local category repository.
class LocalCategoryRepository implements CategoryRepositoryInterface {
  final StreamController<List<Category>> _categoryController =
      BehaviorSubject<List<Category>>();

  final StreamController<List<Category>> _selectedCategoriesController =
      BehaviorSubject<List<Category>>();

  final _categories = <Category>[
    const Category(id: "1", name: "Bread"),
    const Category(id: "2", name: "Cheese"),
    const Category(id: "3", name: "Drinks"),
  ];

  final List<Category> _selectedCategories = [];

  @override
  Stream<List<Category>> getCategories() {
    _categoryController.add(_categories);
    return _categoryController.stream;
  }

  @override
  Stream<List<Category>?> getSelectedCategoryStream() {
    _selectedCategoriesController.add(_selectedCategories);
    return _selectedCategoriesController.stream;
  }

  @override
  Category? selectCategory(String? categoryId) {
    var selectedCategory =
        _categories.firstWhereOrNull((category) => category.id == categoryId);
    if (selectedCategory == null) return null;
    _selectedCategories.add(selectedCategory);
    _selectedCategoriesController.add(_selectedCategories);
    return selectedCategory;
  }

  @override
  void deselectCategory(String? categoryId) {
    _selectedCategories.removeWhere((category) => category.id == categoryId);
    _selectedCategoriesController.add(_selectedCategories);
  }
}
