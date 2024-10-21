import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shopping_repository_interface/shopping_repository_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseShopRepository implements ShopRepositoryInterface {
  final StreamController<List<Shop>> _shopController =
      BehaviorSubject<List<Shop>>();

  Shop? _selectedShop;

  List<Shop> _shops = [];

  @override
  Shop? getSelectedShop() {
    return _selectedShop;
  }

  @override
  Shop? getShop(String? shopId) {
    return _shops.firstWhere((element) => element.id == shopId);
  }

  @override
  Stream<List<Shop>> getShops() {
    FirebaseFirestore.instance
        .collection('shopping_shop')
        .snapshots()
        .listen((event) {
      List<Shop> shops = [];
      event.docs.forEach((element) {
        shops.add(Shop.fromMap(element.id, element.data()));
      });
      _shops = shops;
      _shopController.add(shops);
    });

    return _shopController.stream;
  }

  @override
  Shop? selectShop(String? shopId) {
    _selectedShop = _shops.firstWhere((element) => element.id == shopId);
    return _selectedShop;
  }
}
