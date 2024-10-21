import "package:shopping_repository_interface/src/models/shop.dart";

/// The shop repository interface.
abstract class ShopRepositoryInterface {
  /// Get the shops.
  Stream<List<Shop>> getShops();

  /// Select a shop.
  Shop? selectShop(String? shopId);

  /// Get the selected shop.
  Shop? getSelectedShop();

  /// Get the shop.
  Shop? getShop(String? shopId);
}
