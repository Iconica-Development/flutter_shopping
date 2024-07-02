import "package:flutter_shopping_interface/src/model/product.dart";

/// Order service
// ignore: one_member_abstracts
abstract class OrderService {
  /// Create an order
  Future<void> createOrder(
    int shopId,
    List<Product> products,
    Map<String, dynamic> clientInformation,
  );
}
