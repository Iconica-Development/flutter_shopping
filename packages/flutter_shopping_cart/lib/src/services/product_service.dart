import "package:flutter/foundation.dart";
import "package:flutter_shopping_cart/flutter_shopping_cart.dart";

/// Product service. This class is responsible for managing the products.
/// The service is used to add, remove, and update products.
class ProductService<T extends ShoppingCartProduct> extends ChangeNotifier {
  /// Creates a product service.
  ProductService(this.products);

  /// List of products in the shopping cart.
  final List<T> products;

  /// Adds a product to the shopping cart.
  void addProduct(T product) {
    for (var p in products) {
      if (p.id == product.id) {
        p.quantity++;
        notifyListeners();
        return;
      }
    }

    products.add(product);
    notifyListeners();
  }

  /// Removes a product from the shopping cart.
  void removeProduct(T product) {
    for (var p in products) {
      if (p.id == product.id) {
        products.remove(p);
        notifyListeners();
        return;
      }
    }
    notifyListeners();
  }

  /// Removes one product from the shopping cart.
  void removeOneProduct(T product) {
    for (var p in products) {
      if (p.id == product.id) {
        if (p.quantity > 1) {
          p.quantity--;
          notifyListeners();
          return;
        }
      }
    }

    products.remove(product);
    notifyListeners();
  }

  /// Counts the number of products in the shopping cart.
  int countProducts() {
    var count = 0;

    for (var product in products) {
      count += product.quantity;
    }

    return count;
  }

  /// Empties the shopping cart.
  void clear() {
    products.clear();
    notifyListeners();
  }
}
