import "package:flutter_shopping_interface/src/model/product.dart";

/// Order service
// ignore: one_member_abstracts
abstract class OrderService {
  /// Create an order
  Future<void> createOrder(
    String shopId,
    List<Product> products,
    Map<int, Map<String, dynamic>> clientInformation,
  );
}
