import "package:flutter/material.dart";
import "package:flutter_product_page/src/configuration/product_page_configuration.dart";
import "package:flutter_product_page/src/ui/product_page.dart";

/// A screen that displays a product page. This screen contains a Scaffold,
/// in which the body is a SafeArea that contains a ProductPage widget.
///
/// If you do not wish to create a Scaffold you can use the
/// [ProductPage] widget directly.
class ProductPageScreen extends StatelessWidget {
  /// Constructor for the product page screen.
  const ProductPageScreen({
    required this.configuration,
    this.initialBuildShopId,
    super.key,
  });

  /// Configuration for the product page.
  final ProductPageConfiguration configuration;

  /// An optional initial shop ID to select. This overrides the initialShopId
  /// from the configuration.
  final String? initialBuildShopId;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: configuration.appBar!.call(context),
        body: SafeArea(
          child: ProductPage(
            configuration: configuration,
            initialBuildShopId: initialBuildShopId,
          ),
        ),
        bottomNavigationBar: configuration.bottomNavigationBar,
      );
}
