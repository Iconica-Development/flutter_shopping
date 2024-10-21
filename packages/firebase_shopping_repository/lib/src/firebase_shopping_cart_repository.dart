import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shopping_repository_interface/shopping_repository_interface.dart';

class FirebaseShoppingCartRepository
    implements ShoppingCartRepositoryInterface {
  var _cart = ShoppingCart(id: "1", products: []);
  final StreamController<ShoppingCart> _shoppingCartController =
      BehaviorSubject<ShoppingCart>();

  @override
  Future<void> addProductToCart(Product product) async {
    var existingProducts = _cart.products;
    var index = existingProducts.indexWhere((p) => p.id == product.id);

    if (index != -1) {
      existingProducts[index] = product.copyWith(
        selectedAmount: existingProducts[index].selectedAmount + 1,
      );
      _cart = _cart.copyWith(
        products: existingProducts,
        totalAmount: _cart.totalAmount + product.price,
        totalAmountWithDiscount: product.isDiscounted
            ? _cart.totalAmountWithDiscount + product.discountPrice
            : _cart.totalAmountWithDiscount + product.price,
      );
    } else {
      _cart = _cart.copyWith(
        products: [...existingProducts, product.copyWith(selectedAmount: 1)],
        totalAmount: _cart.totalAmount + product.price,
        totalAmountWithDiscount: product.isDiscounted
            ? _cart.totalAmountWithDiscount + product.discountPrice
            : _cart.totalAmountWithDiscount + product.price,
      );
    }

    _shoppingCartController.add(_cart);
  }

  @override
  Stream<int> getCartLength() {
    return _shoppingCartController.stream.map((cart) => cart.products.length);
  }

  @override
  Stream<ShoppingCart> getShoppingCart() {
    return _shoppingCartController.stream;
  }

  @override
  Future<void> removeProductFromCart(Product product) {
    var existingProducts = _cart.products;
    if (existingProducts.contains(product)) {
      var index = existingProducts.indexOf(product);
      if (product.selectedAmount == 1) {
        existingProducts.removeAt(index);
      } else {
        existingProducts[index] = product.copyWith(
          selectedAmount: existingProducts[index].selectedAmount - 1,
        );
      }

      _cart = _cart.copyWith(
        products: existingProducts,
        totalAmount: _cart.totalAmount - product.price,
        totalAmountWithDiscount: product.isDiscounted
            ? _cart.totalAmountWithDiscount - product.discountPrice
            : _cart.totalAmountWithDiscount - product.price,
      );

      _shoppingCartController.add(_cart);
    }

    return Future.value();
  }
}
