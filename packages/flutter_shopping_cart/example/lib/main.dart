import "package:flutter/material.dart";
import "package:flutter_localizations/flutter_localizations.dart";
import "package:flutter_shopping_cart/flutter_shopping_cart.dart";
import "package:flutter_shopping_cart_example/configuration/shopping_cart_configuration.dart";
import "package:flutter_shopping_cart_example/models/example_product.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("nl", "NL"),
        ],
        home: const Scaffold(
          body: _ShoppingCartScreen(),
        ),
      );
}

class _ShoppingCartScreen extends StatelessWidget {
  const _ShoppingCartScreen();

  @override
  Widget build(BuildContext context) {
    var productService = ProductService<ExampleProduct>([]);

    return ShoppingCartScreen<ExampleProduct>(
      configuration: getShoppingCartConfiguration(
        context,
        productService,
      ),
    );
  }
}
