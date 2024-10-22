import "dart:async";

import "package:rxdart/rxdart.dart";
import "package:shopping_repository_interface/shopping_repository_interface.dart";

/// The local shopping cart repository.
class LocalShoppingCartRepository implements ShoppingCartRepositoryInterface {
  /// The shopping cart.
  ShoppingCart shoppingCart = const ShoppingCart(
    id: "1",
    products: [],
    totalAmount: 0.0,
    totalAmountWithDiscount: 0.0,
  );

  final StreamController<ShoppingCart> _shoppingCartController =
      BehaviorSubject<ShoppingCart>();

  @override
  Future<void> addProductToCart(Product product) async {
    var existingProducts = shoppingCart.products;
    var index = existingProducts.indexWhere((p) => p.id == product.id);

    if (index != -1) {
      existingProducts[index] = product.copyWith(
        selectedAmount: existingProducts[index].selectedAmount + 1,
      );
      shoppingCart = shoppingCart.copyWith(
        products: existingProducts,
        totalAmount: shoppingCart.totalAmount + product.price,
        totalAmountWithDiscount: product.isDiscounted
            ? shoppingCart.totalAmountWithDiscount + product.discountPrice
            : shoppingCart.totalAmountWithDiscount + product.price,
      );
    } else {
      shoppingCart = shoppingCart.copyWith(
        products: [...existingProducts, product.copyWith(selectedAmount: 1)],
        totalAmount: shoppingCart.totalAmount + product.price,
        totalAmountWithDiscount: product.isDiscounted
            ? shoppingCart.totalAmountWithDiscount + product.discountPrice
            : shoppingCart.totalAmountWithDiscount + product.price,
      );
    }

    _shoppingCartController.add(shoppingCart);
  }

  @override
  Stream<int> getCartLength() =>
      _shoppingCartController.stream.map((cart) => cart.products.length);

  @override
  Stream<ShoppingCart> getShoppingCart() => _shoppingCartController.stream;

  @override
  Future<void> removeProductFromCart(Product product) async {
    var existingProducts = shoppingCart.products;
    if (existingProducts.contains(product)) {
      var index = existingProducts.indexOf(product);
      if (product.selectedAmount == 1) {
        existingProducts.removeAt(index);
      } else {
        existingProducts[index] =
            product.copyWith(selectedAmount: product.selectedAmount - 1);
      }
    }
    shoppingCart = shoppingCart.copyWith(
      products: existingProducts,
      totalAmount: shoppingCart.totalAmount + product.price,
      totalAmountWithDiscount: product.isDiscounted
          ? shoppingCart.totalAmountWithDiscount - product.discountPrice
          : shoppingCart.totalAmountWithDiscount - product.price,
    );
    _shoppingCartController.add(shoppingCart);
  }
}
