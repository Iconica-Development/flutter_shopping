import "package:flutter/material.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// A service that provides a list of shops.
class LocalShopService with ChangeNotifier implements ShopService {
  Shop? _selectedShop;

  @override
  Future<List<Shop>> getShops() async {
    await Future.delayed(const Duration(seconds: 1));
    var shops = <Shop>[
      const Shop(id: "1", name: "Bakkerij de Goudkorst"),
      const Shop(id: "2", name: "Slagerij PuurVlees"),
      const Shop(id: "3", name: "De GroenteHut"),
      const Shop(id: "4", name: "Pizzeria Ciao"),
      const Shop(id: "5", name: "Cafetaria Roos"),
      const Shop(id: "6", name: "Zeebries Visdelicatessen"),
      const Shop(id: "7", name: "De Oosterse Draak"),
    ];
    return Future.value(shops);
  }

  /// Updates the selected shop.
  @override
  void selectShop(Shop shop) {
    if (_selectedShop == shop) return;

    _selectedShop = shop;
    notifyListeners();
  }

  /// The currently selected shop.
  @override
  Shop? get selectedShop => _selectedShop;
}
