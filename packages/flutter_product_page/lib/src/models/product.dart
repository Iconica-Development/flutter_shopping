/// The product page shop class contains all the required information
class Product {
  /// Constructor for the product.
  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.price,
    required this.hasDiscount,
    this.discountPrice,
    this.quantity = 1,
  });

  /// The unique identifier for the product.
  final String id;

  /// The name of the product.
  final String name;

  /// The image URL of the product.
  final String imageUrl;

  /// The category of the product.
  final String category;

  /// The price of the product.
  final double price;

  /// Whether the product has a discount or not.
  final bool hasDiscount;

  /// The discounted price of the product. Only used if [hasDiscount] is true.
  final double? discountPrice;

  /// Quantity for the product.
  final int quantity;
}
