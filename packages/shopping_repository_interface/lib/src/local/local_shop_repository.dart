import "package:shopping_repository_interface/src/interfaces/shop_repository_interface.dart";
import "package:shopping_repository_interface/src/models/shop.dart";

/// The local shop repository.
class LocalShopRepository implements ShopRepositoryInterface {
  final List<Shop> _shops = [
    const Shop(id: "1", name: "Bakkerij de Goudkorst", adress: "Bakkerssteeg"),
    const Shop(id: "2", name: "De Verse Melkkan", adress: "Melkweg"),
    const Shop(id: "3", name: "De Gouden Kaasplank", adress: "Kaashof"),
  ];

  Shop? _selectedShop;

  @override
  Stream<List<Shop>> getShops() => Stream.value(_shops);

  @override
  Shop? getShop(String? shopId) =>
      _shops.firstWhere((shop) => shop.id == shopId);

  @override
  Shop? getSelectedShop() => _selectedShop;

  @override
  Shop? selectShop(String? shopId) {
    _selectedShop = _shops.firstWhere((shop) => shop.id == shopId);
    return _selectedShop;
  }
}
