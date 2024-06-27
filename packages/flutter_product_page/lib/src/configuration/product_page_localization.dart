/// Localization for the product page
class ProductPageLocalization {
  /// Default constructor
  const ProductPageLocalization({
    this.navigateToShoppingCart = "View shopping cart",
    this.discountTitle = "Weekly offer",
    this.failedToLoadImageExplenation = "Failed to load image",
    this.close = "Close",
  });

  /// Message to navigate to the shopping cart
  final String navigateToShoppingCart;

  /// Title for the discount
  final String discountTitle;

  /// Explenation when the image failed to load
  final String failedToLoadImageExplenation;

  /// Close button for the product page
  final String close;
}
