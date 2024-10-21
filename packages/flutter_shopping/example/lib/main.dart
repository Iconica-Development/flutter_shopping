import 'package:example/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shopping/flutter_shopping.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const FlutterShopping(),
    );
  }
}

class FlutterShopping extends StatelessWidget {
  const FlutterShopping({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterShoppingNavigatorUserstory(
      options: const FlutterShoppingOptions(),
      translations: const ShoppingTranslations(),
      shoppingService: ShoppingService(),
      initialShopId: "1",
    );
  }
}
