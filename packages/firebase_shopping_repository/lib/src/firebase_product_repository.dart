import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shopping_repository_interface/shopping_repository_interface.dart';

class FirebaseProductRepository implements ProductRepositoryInterface {
  /// Shop one product

  final List<Product> _products = [];

  Product? _selectedProduct;

  final StreamController<List<Product>> _productStream =
      BehaviorSubject<List<Product>>();

  @override
  Product? getProduct(String? productId) =>
      _products.firstWhere((product) => product.id == productId);

  @override
  Stream<List<Product>> getProducts(List<Category>? categories, String shopId) {
    FirebaseFirestore.instance
        .collection('shopping_products')
        .doc(shopId)
        .snapshots()
        .listen((event) {
      _products.clear();

      if (event.data() == null) return;
      var shopProducts = event.data()!['products'] as List<dynamic>;
      print(categories);
      if (categories != null && categories.isNotEmpty)
        shopProducts = shopProducts
            .where(
              (product) => categories
                  .any((category) => category.name == product['category']),
            )
            .toList();
      shopProducts.forEach((product) {
        _products.add(Product.fromMap(product));
      });
      _productStream.add(_products);
    });

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
