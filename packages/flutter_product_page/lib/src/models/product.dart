/// The product page shop class contains all the required information
///
/// This is a mixin class because another package will implement it, and the
/// 'MyProduct' class might have to extend another class as well.
mixin ProductPageProduct {
  /// The unique identifier for the product.
  String get id;

  /// The name of the product.
  String get name;

  /// The image URL of the product.
  String get imageUrl;

  /// The category of the product.
  String get category;

  /// The price of the product.
  double get price;

  /// Whether the product has a discount or not.
  bool get hasDiscount;

  /// The discounted price of the product. Only used if [hasDiscount] is true.
  double? get discountPrice;
}
