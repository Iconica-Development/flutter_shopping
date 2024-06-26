import "package:flutter/material.dart";
import "package:flutter_product_page/src/models/product_page_shop.dart";

/// A service that provides the currently selected shop.
class SelectedShopService extends ChangeNotifier {
  /// Creates a [SelectedShopService].
  SelectedShopService();

  ProductPageShop? _selectedShop;

  /// Updates the selected shop.
  void selectShop(ProductPageShop shop) {
    if (_selectedShop == shop) return;

    _selectedShop = shop;
    notifyListeners();
  }

  /// The currently selected shop.
  ProductPageShop? get selectedShop => _selectedShop;
}
