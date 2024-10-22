import "package:shopping_repository_interface/src/models/category.dart";

/// The category repository interface.
abstract class CategoryRepositoryInterface {
  /// Get the categories.
  Stream<List<Category>> getCategories();

  /// Select a category.
  Category? selectCategory(String? categoryId);

  /// Get the selected category stream.
  Stream<List<Category>?> getSelectedCategoryStream();

  /// Deselect a category.
  void deselectCategory(String? categoryId);
}
