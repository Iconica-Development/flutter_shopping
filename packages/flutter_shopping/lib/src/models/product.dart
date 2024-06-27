/// The product class contains all the information that a product can have.
/// This class is used in the shopping cart and the product page.
class Product {
  /// Creates a product.
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
  int quantity;
}
