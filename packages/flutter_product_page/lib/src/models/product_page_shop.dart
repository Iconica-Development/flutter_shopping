/// The product page shop class contains all the required information
/// that needs to be known about a certain shop.
///
/// In your own implemententation, you must extend from this class so you can
/// add more fields to this class to suit your needs.
class ProductPageShop {
  /// The default constructor for this class.
  const ProductPageShop({
    required this.id,
    required this.name,
  });

  /// The unique identifier for the shop.
  final String id;

  /// The name of the shop.
  final String name;
}
