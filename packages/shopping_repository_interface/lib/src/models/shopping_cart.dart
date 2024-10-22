import "package:shopping_repository_interface/shopping_repository_interface.dart";

/// The shopping cart.
class ShoppingCart {
  /// The shopping cart.
  const ShoppingCart({
    required this.id,
    required this.products,
    this.totalAmount = 0.00,
    this.totalAmountWithDiscount = 0.0,
  });

  /// The id.
  final String id;

  /// The products.
  final List<Product> products;

  /// The total amount.
  final double totalAmount;

  /// The total amount with discount.
  final double totalAmountWithDiscount;

  /// Copy the shopping cart with new values.
  ShoppingCart copyWith({
    String? id,
    List<Product>? products,
    double? totalAmount,
    double? totalAmountWithDiscount,
  }) =>
      ShoppingCart(
        id: id ?? this.id,
        products: products ?? this.products,
        totalAmount: totalAmount ?? this.totalAmount,
        totalAmountWithDiscount:
            totalAmountWithDiscount ?? this.totalAmountWithDiscount,
      );
}
