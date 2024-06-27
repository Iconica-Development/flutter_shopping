import "package:flutter_shopping/flutter_shopping.dart";

/// Return type that contains the products and an optional discounted product.
class ProductPageContent {
  /// Default constructor for this class.
  const ProductPageContent({
    required this.products,
    this.discountedProduct,
  });

  /// List of products that belong to the shop.
  final List<Product> products;

  /// Optional highlighted discounted product to display.
  final Product? discountedProduct;
}
