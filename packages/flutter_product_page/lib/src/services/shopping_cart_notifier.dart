import "package:flutter/material.dart";

/// Class that notifies listeners when the products in the shopping cart have
/// changed.
class ShoppingCartNotifier extends ChangeNotifier {
  /// Notifies listeners that the products in the shopping cart have changed.
  void productsChanged() {
    notifyListeners();
  }
}
