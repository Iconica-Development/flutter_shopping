import "package:example/models/my_product.dart";
import "package:example/models/my_shop.dart";
import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";

ProductPageConfiguration getProductPageScreenConfiguration({
  required List<MyShop> shops,
  required List<MyProduct> products,
}) =>
    ProductPageConfiguration(
      // (REQUIRED) List of shops to display.
      shops: Future.value(shops),

      // (REQUIRED) Function that returns the products for a shop.
      getProducts: (ProductPageShop shop) => Future<ProductPageContent>(
        () => ProductPageContent(
          products: products,
          discountedProduct: products.firstWhere(
            (MyProduct product) => product.hasDiscount,
          ),
        ),
      ),

      // (REQUIRED) Function that handles the functionality behind adding
      // a product to the cart.
      // ignore: avoid_print
      onAddToCart: (product) => print("Add to cart: ${product.name}"),

      // (REQUIRED) Function that handles the functionality behind navigating
      // to the product detail page.
      // ignore: avoid_print
      onNavigateToShoppingCart: () => print("Navigate to shopping cart"),

      // (RECOMMENDED) The shop that is initially selected.
      // Must be one of the shops in the [shops] list.
      initialShopId: shops.first.id,

      // (RECOMMENDED) Function that returns the amount of products in the
      // shopping cart. This currently is mocked and should be replaced with
      // a real implementation.
      // getProductsInShoppingCart: () => 0,

      // (RECOMMENDED) Function that is fired when the shop selection changes.
      // You could use this to clear your shopping cart or to change the
      // products so they belong to the correct shop again.
      onShopSelectionChange: (ProductPageShop shop) =>
          // ignore: avoid_print
          print("Shop selected: ${shop.id}"),

      // (RECOMMENDED) Localizations for the product page.
      localizations: const ProductPageLocalization(
        navigateToShoppingCart: "Naar Winkelmandje",
        discountTitle: "Weekaanbieding",
        failedToLoadImageExplenation: "Afbeelding laden mislukt.",
        close: "Sluiten",
      ),

      // (RECOMMENDED) Function that returns the description for a product
      // that is on sale.
      getDiscountDescription: (ProductPageProduct product) =>
          """Koop nu ${product.name} voor slechts €${product.discountPrice?.toStringAsFixed(2)}""",

      /*
        Some recommended functions to implement for additional customizability:
        
        Widget Function(BuildContext, Product)? productBuilder,
        Widget Function(BuildContext, Product)? productPopupBuilder,
        Widget Function(BuildContext)? noContentBuilder,
        Widget Function(BuildContext, Object?, StackTrace?)? errorBuilder,
      */

      // (OPTIONAL) Styling for the shop selector
      shopSelectorStyle: ShopSelectorStyle.row,

      // (OPTIONAL) Builder for the product item.
      appBar: AppBar(
        title: const Text(
          "Producten pagina",
        ),
      ),
    );
