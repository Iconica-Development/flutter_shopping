import "package:example/src/models/my_product.dart";
import "package:example/src/routes.dart";
import "package:example/src/services/order_service.dart";
import "package:example/src/services/shop_service.dart";
import "package:flutter/material.dart";
import "package:flutter_shopping/flutter_shopping.dart";
import "package:go_router/go_router.dart";

// (REQUIRED): Create your own instance of the ProductService.
final ProductService<MyProduct> productService = ProductService([]);

FlutterShoppingConfiguration getFlutterShoppingConfiguration() =>
    FlutterShoppingConfiguration(
      // (REQUIRED): Shop builder configuration
      shopBuilder: (
        BuildContext context,
        String? initialBuildShopId,
        String? streetName,
      ) =>
          ProductPageScreen(
        configuration: ProductPageConfiguration(
          // (REQUIRED): List of shops that should be displayed
          // If there is only one, make a list with just one shop.
          shops: Future.value(getShops()),

          // (REQUIRED): Function to add a product to the cart
          onAddToCart: (ProductPageProduct product) =>
              productService.addProduct(product as MyProduct),

          // (REQUIRED): Function to get the products for a shop
          getProducts: (ProductPageShop shop) =>
              Future<ProductPageContent>.value(
            getShopContent(shop.id),
          ),

          // (REQUIRED): Function to navigate to the shopping cart
          onNavigateToShoppingCart: () async => onCompleteProductPage(context),

          // (RECOMMENDED): Function to get the number of products in the
          // shopping cart. This is used to display the number of products
          // in the shopping cart on the product page.
          getProductsInShoppingCart: productService.countProducts,

          // (RECOMMENDED) Function that returns the description for a
          // product that is on sale.
          getDiscountDescription: (ProductPageProduct product) =>
              """${product.name} for just \$${product.discountPrice?.toStringAsFixed(2)}""",

          // (RECOMMENDED) Function that is fired when the shop selection
          // changes. You could use this to clear your shopping cart or to
          // change the products so they belong to the correct shop again.
          onShopSelectionChange: (ProductPageShop shop) =>
              productService.clear(),

          // (RECOMMENDED) The shop that is initially selected.
          // Must be one of the shops in the [shops] list.
          initialShopId: getShops().first.id,

          // (RECOMMENDED) Localizations for the product page.
          localizations: const ProductPageLocalization(),

          // (OPTIONAL) Appbar
          appBar: AppBar(
            title: const Text("Shop"),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                context.go(homePage);
              },
            ),
          ),
        ),

        // (OPTIONAL): Initial build shop id that overrides the initialShop
        initialBuildShopId: initialBuildShopId,
      ),

      // (REQUIRED): Shopping cart builder configuration
      shoppingCartBuilder: (BuildContext context) => ShoppingCartScreen(
        configuration: ShoppingCartConfig(
          // (REQUIRED) product service instance:
          productService: productService,

          // (REQUIRED) product item builder:
          productItemBuilder: (context, locale, product) => ListTile(
            title: Text(product.name),
            subtitle: Text(product.price.toStringAsFixed(2)),
            leading: Image.network(
              product.imageUrl,
              errorBuilder: (context, error, stackTrace) => const Tooltip(
                message: "Error loading image",
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
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
          onConfirmOrder: (products) async => onCompleteShoppingCart(context),

          // (RECOMMENDED) localizations:
          localizations: const ShoppingCartLocalizations(),

          // (OPTIONAL) title above product list:
          title: "Products",

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
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                context.go(FlutterShoppingPathRoutes.shop);
              },
            ),
          ),
        ),
      ),

      // (REQUIRED): Configuration on what to do when the user story is
      // completed.
      onCompleteUserStory: (BuildContext context) {
        context.go(homePage);
      },

      // (RECOMMENDED) Handle processing of the order details. This function
      // should return true if the order was processed successfully, otherwise
      // false.
      //
      // If this function is not provided, it is assumed that the order is
      // always processed successfully.
      //
      // Example use cases that could be implemented here:
      // - Sending and storing the order on a server,
      // - Processing payment (if the user decides to pay upfront).
      // - And many more...
      onCompleteOrderDetails:
          (BuildContext context, OrderResult orderDetails) async {
        if (orderDetails.order["payment_option"] == "Pay now") {
          // Make the user pay upfront.
        }

        // If all went well, we can store the order in the database.
        // Make sure to register whether or not the order was paid.
        storeOrderInDatabase(productService.products, orderDetails);

        return true;
      },
    );
