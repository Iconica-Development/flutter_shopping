import "package:shopping_repository_interface/shopping_repository_interface.dart";

/// The shopping cart repository interface.
abstract class ShoppingCartRepositoryInterface {
  /// Get the cart length.
  Stream<int> getCartLength();

  /// Get the shopping cart.
  Stream<ShoppingCart> getShoppingCart();

  /// Add a product to the cart.
  Future<void> addProductToCart(Product product);

  /// Remove a product from the cart.
  Future<void> removeProductFromCart(Product product);
}
