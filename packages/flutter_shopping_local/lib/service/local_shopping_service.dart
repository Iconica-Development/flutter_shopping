import "package:flutter_shopping_interface/flutter_shopping_interface.dart";
import "package:flutter_shopping_local/service/local_order_service.dart";
import "package:flutter_shopping_local/service/local_product_service.dart";
import "package:flutter_shopping_local/service/local_shop_service.dart";
import "package:flutter_shopping_local/service/local_shopping_cart_service.dart";

/// Local shopping service
class LocalShoppingService implements ShoppingService {
  /// Local shopping service constructor
  LocalShoppingService({
    this.localOrderService,
    this.localShopService,
    this.localProductService,
    this.localShoppingCartService,
  }) {
    localOrderService ??= LocalOrderService();
    localShopService ??= LocalShopService();
    localProductService ??= LocalProductService();
    localShoppingCartService ??= LocalShoppingCartService();
  }

  /// Local order service
  OrderService? localOrderService;

  /// Local shop service
  ShopService? localShopService;

  /// Local product service
  ProductService? localProductService;

  /// Local shopping cart service
  ShoppingCartService? localShoppingCartService;

  @override
  OrderService get orderService => localOrderService!;

  @override
  ProductService get productService => localProductService!;

  @override
  ShopService get shopService => localShopService!;

  @override
  ShoppingCartService get shoppingCartService => localShoppingCartService!;
}
