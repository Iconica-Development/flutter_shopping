import "package:flutter/material.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// Local shopping cart service
class LocalShoppingCartService
    with ChangeNotifier
    implements ShoppingCartService {
  final List<Product> _products = [];
  @override
  void addProduct(Product product) {
    if (_products.contains(product)) {
      var index = _products.indexOf(product);
      _products[index].quantity++;
    } else {
      _products.add(product);
    }
    notifyListeners();
  }

  @override
  void clear() {
    _products.clear();
    notifyListeners();
  }

  @override
  int countProducts() {
    var count = 0;
    for (var product in _products) {
      count += product.quantity;
    }
    notifyListeners();
    return count;
  }

  @override
  void removeOneProduct(Product product) {
    if (_products.contains(product)) {
      var index = _products.indexOf(product);
      if (_products[index].quantity > 1) {
        _products[index].quantity--;
      } else {
        _products.removeAt(index);
      }
    }
    notifyListeners();
  }

  @override
  void removeProduct(Product product) {
    if (_products.contains(product)) {
      var index = _products.indexOf(product);
      _products.removeAt(index);
    }
    notifyListeners();
  }
}
