import "package:flutter/material.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// Local product service
class LocalProductService with ChangeNotifier implements ProductService {
  List<Product> _products = [];

  @override
  List<String> getCategories() =>
      _products.map((e) => e.category).toSet().toList();

  @override
  Future<Product> getProduct(String id) =>
      Future.value(_products.firstWhere((element) => element.id == id));

  @override
  Future<List<Product>> getProducts(String shopId) async {
    await Future.delayed(const Duration(seconds: 1));
    _products = [
      Product(
        id: "1",
        name: "White Bread",
        imageUrl: "https://firebasestorage.googleapis.com/v0/b/appshell-demo"
            ".appspot.com/o/shopping%2Fwhite.png"
            "?alt=media&token=e3aa13d5-932a-4119-bdbb-89c1a1d82213",
        category: "Bread",
        price: 1.0,
        description: "This is a delicious white bread",
        hasDiscount: true,
        discountPrice: 0.5,
      ),
      Product(
        id: "2",
        name: "Brown Bread",
        imageUrl: "https://firebasestorage.googleapis.com/v0/b/appshell-"
            "demo.appspot.com/o/shopping%2Fbrown.png?alt=media&"
            "token=fbfe280d-44e6-4cde-a491-bcb7f598d22c",
        category: "Bread",
        price: 2.0,
        description: "This is a delicious brown bread",
      ),
      Product(
        id: "3",
        name: "White fish",
        imageUrl: "https://firebasestorage.googleapis.com/v0/b/appshell"
            "-demo.appspot.com/o/shopping%2Fwhite-fish.png?alt=media"
            "&token=61c44f84-347d-4b42-a10d-c172f167929b",
        category: "Fish",
        price: 1.5,
        description: "This is a delicious white fish",
      ),
      Product(
        id: "4",
        name: "Brown fish",
        imageUrl: "https://firebasestorage.googleapis.com/v0/b/appshel"
            "l-demo.appspot.com/o/shopping%2Fbrown-fish.png?alt=media&"
            "token=b743a53c-c4bb-49ac-8894-a08132992902",
        category: "Fish",
        price: 1.5,
        description: "This is a delicious Brown fish",
      ),
    ];
    return Future.value(_products);
  }

  @override
  List<Product> get products => _products;
}
