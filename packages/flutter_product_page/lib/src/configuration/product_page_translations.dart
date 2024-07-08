/// Localization for the product page
class ProductPageTranslations {
  /// Default constructor
  const ProductPageTranslations({
    this.navigateToShoppingCart = "View shopping cart",
    this.discountTitle = "Weekly offer",
    this.failedToLoadImageExplenation = "Failed to load image",
    this.close = "Close",
    this.categoryItemListTitle = "What would you like to order",
    this.appBarTitle = "ProductPage",
  });

  /// Message to navigate to the shopping cart
  final String navigateToShoppingCart;

  /// Title for the discount
  final String discountTitle;

  /// Explenation when the image failed to load
  final String failedToLoadImageExplenation;

  /// Close button for the product page
  final String close;

  /// Title for the category item list
  final String categoryItemListTitle;

  /// Title for the app bar
  final String appBarTitle;
}
