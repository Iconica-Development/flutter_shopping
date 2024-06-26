import "package:flutter_product_page/flutter_product_page.dart";
import "package:flutter_shopping_cart/flutter_shopping_cart.dart";

class MyProduct extends ShoppingCartProduct with ProductPageProduct {
  MyProduct({
    required super.id,
    required super.name,
    required super.price,
    required this.category,
    required this.imageUrl,
    this.discountPrice,
    this.hasDiscount = false,
  });

  @override
  final String category;

  @override
  final String imageUrl;

  @override
  final double? discountPrice;

  @override
  final bool hasDiscount;
}
