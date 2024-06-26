import "dart:math";

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_shopping_cart/flutter_shopping_cart.dart";
import "package:flutter_shopping_cart_example/models/example_product.dart";

ShoppingCartConfig<ExampleProduct> getShoppingCartConfiguration(
  BuildContext ctx,
  ProductService<ExampleProduct> productService,
) =>
    ShoppingCartConfig<ExampleProduct>(
      // (REQUIRED) product service instance:
      productService: productService,

      // (REQUIRED) product item builder:
      productItemBuilder: (
        BuildContext context,
        Locale locale,
        ExampleProduct product,
      ) =>
          ListTile(
        title: Text(product.name),
        subtitle: Text(product.price.toStringAsFixed(2)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => productService.removeOneProduct(product),
            ),
            Text("${product.quantity}"),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => productService.addProduct(product),
            ),
          ],
        ),
      ),

      // (OPTIONAL/REQUIRED) on confirm order callback:
      // Either use this callback or the placeOrderButtonBuilder.
      onConfirmOrder: (List<ExampleProduct> products) {
        if (kDebugMode) {
          print("Placing order with products: $products");
        }
      },

      // (OPTIONAL/REQUIRED) place order button height:
      // Either use this or the onConfirmOrder callback.
      // confirmOrderButtonBuilder: (context) => ElevatedButton(
      //   onPressed: () {
      //     print("meow!");
      //   },
      //   child: Text("Place Order"),
      // ),

      // (OPTIONAL) (RECOMMENDED) localizations:
      localizations: ShoppingCartLocalizations(
        placeOrder: "BESTEL",
        sum: "Te betalen",
        locale: Localizations.localeOf(ctx),
      ),

      // (OPTIONAL) title above product list:
      title: "Producten",

      // (OPTIONAL) custom title builder:
      // titleBuilder: (context) => Text("Products"),

      // (OPTIONAL) padding around the shopping cart:
      padding: const EdgeInsets.symmetric(horizontal: 32),

      // (OPTIONAL) bottom padding of the shopping cart:
      bottomPadding: const EdgeInsets.fromLTRB(44, 0, 44, 32),

      // (OPTIONAL) sum bottom sheet builder:
      // sumBottomSheetBuilder: (context) => Container(...),

      /// (OPTIONAL) no content builder for when there are no products
      /// in the shopping cart.
      noContentBuilder: (context) => const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 128),
          child: Column(
            children: [
              Icon(
                Icons.warning,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Geen producten in winkelmandje",
              ),
            ],
          ),
        ),
      ),

      // (OPTIONAL) custom appbar:
      appBar: AppBar(
        title: const Text("Shopping Cart"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: productService.clear,
          ),
          IconButton(
            onPressed: () {
              var random = Random();
              productService.addProduct(
                ExampleProduct(
                  name: "Example Product",
                  price: 100,
                  image: "https://via.placeholder.com/150",
                  id: "example_product_id${random.nextInt(100000)}",
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
