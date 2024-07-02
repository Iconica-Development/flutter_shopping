import "package:flutter_shopping_interface/src/service/service.dart";

/// Shopping service
class ShoppingService {
  /// Shopping service constructor
  const ShoppingService({
    required this.orderService,
    required this.productService,
    required this.shopService,
    required this.shoppingCartService,
  });

  /// Order service
  final OrderService orderService;

  /// Product service
  final ProductService productService;

  /// Shop service
  final ShopService shopService;

  /// Shopping cart service
  final ShoppingCartService shoppingCartService;
}
