import "package:flutter_product_page/flutter_product_page.dart";

/// Return type that contains the products and an optional discounted product.
class ProductPageContent {
  /// Default constructor for this class.
  const ProductPageContent({
    required this.products,
    this.discountedProduct,
  });

  /// List of products that belong to the shop.
  final List<ProductPageProduct> products;

  /// Optional highlighted discounted product to display.
  final ProductPageProduct? discountedProduct;
}
