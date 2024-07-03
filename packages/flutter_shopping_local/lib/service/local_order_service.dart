import "package:flutter/material.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// Local order service
class LocalOrderService with ChangeNotifier implements OrderService {
  @override
  Future<void> createOrder(
    String shopId,
    List<Product> products,
    Map<int, Map<String, dynamic>> clientInformation,
  ) async {
    // Create the order
    notifyListeners();
  }
}
