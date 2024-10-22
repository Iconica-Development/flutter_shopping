/// A model class representing a product.
class Product {
  /// Constructor for the product.
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.imageUrl,
    required this.category,
    this.isDiscounted = false,
    this.selectedAmount = 0,
  });

  /// Create a product from a map.
  factory Product.fromMap(Map<String, dynamic> map) => Product(
        id: map["id"],
        name: map["name"],
        description: map["description"],
        price: map["price"],
        // ignore: avoid_dynamic_calls
        discountPrice: map["discountPrice"].toDouble(),
        imageUrl: map["imageUrl"],
        category: map["category"],
        isDiscounted: map["isDiscounted"],
        selectedAmount: map["selectedAmount"] ?? 0,
      );

  /// The id of the product.
  final String id;

  /// The name of the product.
  final String name;

  /// The description of the product.
  final String description;

  /// The price of the product.
  final double price;

  /// The discount price of the product.
  final double discountPrice;

  /// The image url of the product.
  final String imageUrl;

  /// The category of the product.
  final String category;

  /// Whether the product is discounted.
  final bool isDiscounted;

  /// The selected amount of the product.
  final int selectedAmount;

  /// Copy the product with new values.
  Product copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? discountPrice,
    String? imageUrl,
    String? category,
    bool? isDiscounted,
    int? selectedAmount,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        discountPrice: discountPrice ?? this.discountPrice,
        imageUrl: imageUrl ?? this.imageUrl,
        category: category ?? this.category,
        isDiscounted: isDiscounted ?? this.isDiscounted,
        selectedAmount: selectedAmount ?? this.selectedAmount,
      );
}
