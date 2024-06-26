import "package:flutter_product_page/flutter_product_page.dart";

class MyProduct with ProductPageProduct {
  const MyProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.hasDiscount,
    required this.discountPrice,
  });

  @override
  final String id;

  @override
  final String name;

  @override
  final double price;

  @override
  final String imageUrl;

  @override
  final String category;

  @override
  final bool hasDiscount;

  @override
  final double? discountPrice;
}
