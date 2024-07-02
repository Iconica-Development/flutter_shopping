import "package:flutter/material.dart";
import "package:flutter_shopping_interface/src/model/shop.dart";

/// Shop service
// ignore: one_member_abstracts
abstract class ShopService with ChangeNotifier {
  /// Retrieve a list of shops
  Future<List<Shop>> getShops();
}
