import "package:flutter/material.dart";
import "package:flutter_shopping_interface/src/model/product.dart";

/// shopping cart service
abstract class ShoppingCartService with ChangeNotifier {
  /// Adds a product to the shopping cart.
  void addProduct(Product product);

  /// Removes a product from the shopping cart.
  void removeProduct(Product product);

  /// Removes one product from the shopping cart.
  void removeOneProduct(Product product);

  /// Counts the number of products in the shopping cart.
  int countProducts();

  /// Clears the shopping cart.
  void clear();

  /// The list of products in the shopping cart.
  List<Product> get products;
}
