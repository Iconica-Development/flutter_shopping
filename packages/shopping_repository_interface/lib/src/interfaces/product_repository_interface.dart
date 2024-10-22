import "package:shopping_repository_interface/shopping_repository_interface.dart";

/// The product repository interface.
abstract class ProductRepositoryInterface {
  /// Get the products.
  Stream<List<Product>> getProducts(List<Category>? categories, String shopId);

  /// Get the product stream.
  Product? selectProduct(String? productId);

  /// Get the product.
  Product? getProduct(String? productId);

  /// Get the weekly offer.
  Product? getWeeklyOffer();
}
