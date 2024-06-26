import "package:flutter_shopping_cart/flutter_shopping_cart.dart";

class ExampleProduct extends ShoppingCartProduct {
  ExampleProduct({
    required super.name,
    required super.price,
    required this.image,
    super.quantity,
    super.id = "example_product_id",
  });

  final String image;
}
