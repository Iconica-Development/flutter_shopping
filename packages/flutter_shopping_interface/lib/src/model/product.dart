/// Product Interface
abstract class ProductInterface {
  /// ProductInterface constructor
  ProductInterface({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.price,
    required this.description,
    this.hasDiscount = false,
    this.discountPrice,
    this.quantity = 1,
  });

  /// Product id
  final String id;

  /// Product name
  final String name;

  /// Product image url
  final String imageUrl;

  /// Product category
  final String category;

  /// Product price
  final double price;

  /// whether the product has a discount
  final bool hasDiscount;

  /// Product discount price
  final double? discountPrice;

  /// Product quantity
  int quantity;

  /// Product description
  final String description;
}

/// Product model
class Product implements ProductInterface {
  /// Product constructor
  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.price,
    required this.description,
    this.hasDiscount = false,
    this.discountPrice,
    this.quantity = 1,
  });

  @override
  final String id;

  @override
  final String name;

  @override
  final String imageUrl;

  @override
  final String category;

  @override
  final double price;

  @override
  final bool hasDiscount;

  @override
  final double? discountPrice;

  @override
  int quantity;

  @override
  final String description;
}
