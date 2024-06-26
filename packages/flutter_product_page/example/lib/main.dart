import "package:example/config/product_page_screen_configuration.dart";
import "package:example/models/my_product.dart";
import "package:example/models/my_shop.dart";
import "package:example/utils/theme.dart";
import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  ///
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var shops = List.generate(
      7,
      (int index) => MyShop(
        id: index.toString(),
        name: "Shop ${(index.isEven ? index * 40 : index) + 1}",
      ),
    );

    var products = List.generate(
      6,
      (int index) => MyProduct(
        id: index.toString(),
        name: "Product ${index + 1}",
        price: 100.0,
        imageUrl: "https://via.placeholder.com/150",
        category: index.isEven ? "Category 1" : "Category 2",
        hasDiscount: index.isEven,
        discountPrice: 50.0,
      ),
    );

    return MaterialApp(
      title: "Flutter Demo",
      theme: getTheme(),
      home: ProductPageScreen(
        configuration: getProductPageScreenConfiguration(
          shops: shops,
          products: products,
        ),
      ),
    );
  }
}
