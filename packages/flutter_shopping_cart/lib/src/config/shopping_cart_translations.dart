/// Shopping cart localizations
class ShoppingCartTranslations {
  /// Creates shopping cart localizations
  const ShoppingCartTranslations({
    this.placeOrder = "Order",
    this.sum = "Subtotal:",
    this.cartTitle = "Products",
    this.close = "close",
  });

  /// Text for the place order button.
  final String placeOrder;

  /// Localization for the sum.
  final String sum;

  /// Title for the shopping cart. This title will be displayed at the top of
  /// the shopping cart.
  final String cartTitle;

  /// Localization for the close button for the popup.
  final String close;
}
