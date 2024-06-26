/// Abstract class for Product
///
/// All products that want to be added to the shopping cart
/// must extend this class.
abstract class ShoppingCartProduct {
  /// Creates a new product.
  ShoppingCartProduct({
    required this.id,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  /// Unique product identifier.
  /// This identifier will be used to identify the product in the shopping cart.
  /// If you don't provide an identifier, a random identifier will be generated.
  final String id;

  /// Product name.
  /// This name will be displayed in the shopping cart.
  final String name;

  /// Product price.
  /// This price will be displayed in the shopping cart.
  final double price;

  /// Quantity for the product.
  int quantity;
}
