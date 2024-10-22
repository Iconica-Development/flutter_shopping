import "dart:async";
import "package:collection/collection.dart";
import "package:rxdart/rxdart.dart";
import "package:shopping_repository_interface/shopping_repository_interface.dart";

/// The local product repository.
class LocalProductRepository implements ProductRepositoryInterface {
  /// Shop one products.
  final shopOne = <Product>[
    const Product(
      id: "1",
      name: "White bread",
      price: 2.50,
      description:
          "White bread is a common type of bread made from ground wheat"
          " flour from which the bran and germ have been removed,"
          " giving it a light color.",
      discountPrice: 1.50,
      imageUrl: "https://shorturl.at/qeY8a",
      category: "Bread",
      isDiscounted: false,
    ),
    const Product(
      id: "2",
      name: "Brown bread",
      price: 2.50,
      description:
          "Brown bread is a common type of bread made from ground wheat"
          " flour from which the bran and germ have been removed,"
          " giving it a light color.",
      discountPrice: 1.50,
      imageUrl: "https://shorturl.at/qeY8a",
      category: "Bread",
      isDiscounted: true,
    ),
    const Product(
      id: "3",
      name: "Corn bread",
      price: 2.50,
      description: "Corn bread is a common type of bread made from ground wheat"
          " flour from which the bran and germ have been removed,"
          " giving it a light color.",
      discountPrice: 1.50,
      imageUrl: "https://shorturl.at/qeY8a",
      category: "Bread",
      isDiscounted: false,
    ),
  ];

  /// Shop two products.
  final shopTwo = <Product>[
    const Product(
      id: "4",
      name: "cow milk",
      price: 1.50,
      description: "Cow milk is a common type of milk, it comes from cows",
      discountPrice: 1.00,
      imageUrl: "https://shorturl.at/RESqM",
      category: "Drinks",
      isDiscounted: true,
    ),
    const Product(
      id: "5",
      name: "goat milk",
      price: 1.50,
      description: "Goat milk is a common type of milk, it comes from goats",
      discountPrice: 1.00,
      imageUrl: "https://shorturl.at/RESqM",
      category: "Drinks",
      isDiscounted: true,
    ),
    const Product(
      id: "6",
      name: "sheep milk",
      price: 1.50,
      description: "Sheep milk is a common type of milk, it comes from sheeps",
      discountPrice: 1.00,
      imageUrl: "https://shorturl.at/RESqM",
      category: "Drinks",
      isDiscounted: true,
    ),
  ];

  /// Shop three products.
  final shopThree = <Product>[
    const Product(
      id: "7",
      name: "young cheese",
      price: 3.50,
      description: "Young cheese is a common type of cheese, it is very nice",
      discountPrice: 2.50,
      imageUrl: "https://shorturl.at/5QMoa",
      category: "Cheese",
      isDiscounted: false,
    ),
    const Product(
      id: "8",
      name: "old cheese",
      price: 3.50,
      description: "Old cheese is a common type of cheese, it is very nice",
      discountPrice: 2.50,
      imageUrl: "https://shorturl.at/5QMoa",
      category: "Cheese",
      isDiscounted: false,
    ),
    const Product(
      id: "9",
      name: "blue cheese",
      price: 3.50,
      description: "Blue cheese is a common type of cheese, it is very nice",
      discountPrice: 2.50,
      imageUrl: "https://shorturl.at/5QMoa",
      category: "Cheese",
      isDiscounted: true,
    ),
  ];

  final List<Product> _products = [];

  Product? _selectedProduct;

  final StreamController<List<Product>> _productStream =
      BehaviorSubject<List<Product>>();

  @override
  Product? getProduct(String? productId) =>
      _products.firstWhere((product) => product.id == productId);

  @override
  Stream<List<Product>> getProducts(List<Category>? categories, String shopId) {
    _products.clear();
    var products = shopId == "1"
        ? shopOne
        : shopId == "2"
            ? shopTwo
            : shopThree;
    if (categories != null && categories.isNotEmpty) {
      _products.addAll(
        products
            .where(
              (product) => categories
                  .any((category) => category.name == product.category),
            )
            .toList(),
      );
    } else {
      _products.addAll(products);
    }

    _productStream.add(_products);

    return _productStream.stream;
  }

  @override
  Product? selectProduct(String? productId) {
    _selectedProduct =
        _products.firstWhere((product) => product.id == productId);
    return _selectedProduct;
  }

  @override
  Product? getWeeklyOffer() =>
      _products.firstWhereOrNull((product) => product.isDiscounted);
}
