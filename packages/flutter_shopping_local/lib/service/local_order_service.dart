import "package:flutter/material.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// Local order service
class LocalOrderService with ChangeNotifier implements OrderService {
  @override
  Future<void> createOrder(
    int shopId,
    List<Product> products,
    Map<String, dynamic> clientInformation,
  ) {
    // No use case for this method yet
    throw UnimplementedError();
  }
}
