import "package:flutter/material.dart";
import "package:flutter_shopping_interface/src/model/product.dart";

/// Product service
abstract class ProductService with ChangeNotifier {
  /// Retrieve a list of products
  Future<List<Product>> getProducts(String shopId);

  /// Retrieve a product
  Future<Product> getProduct(String id);

  /// Retrieve a list of categories
  List<String> getCategories();
}
