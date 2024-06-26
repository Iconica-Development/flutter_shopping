import "package:amazon/src/models/my_product.dart";
import "package:amazon/src/routes.dart";
import "package:amazon/src/services/category_service.dart";
import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";
import "package:flutter_shopping/flutter_shopping.dart";
import "package:flutter_shopping_cart/flutter_shopping_cart.dart";
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
      ) {
        var theme = Theme.of(context);

        return ProductPageScreen(
          configuration: ProductPageConfiguration(
            // (REQUIRED): List of shops that should be displayed
            // If there is only one, make a list with just one shop.
            shops: Future.value(getCategories()),

            pagePadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),

            // (REQUIRED): Function to add a product to the cart
            onAddToCart: (ProductPageProduct product) =>
                productService.addProduct(product as MyProduct),

            // (REQUIRED): Function to get the products for a shop
            getProducts: (ProductPageShop shop) =>
                Future<ProductPageContent>.value(
              getShopContent(shop.id),
            ),

            // (REQUIRED): Function to navigate to the shopping cart
            onNavigateToShoppingCart: () => onCompleteProductPage(context),

            shopSelectorStyle: ShopSelectorStyle.row,

            navigateToShoppingCartBuilder: (context) => const SizedBox.shrink(),

            bottomNavigationBar: BottomNavigationBar(
              fixedColor: theme.primaryColor,
              unselectedItemColor: Colors.black,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_2_outlined),
                  label: "Profile",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined),
                  label: "Cart",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "Menu",
                ),
              ],
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (index) {
                switch (index) {
                  case 0:
                    // context.go(homePage);
                    break;
                  case 1:
                    break;
                  case 2:
                    context.go(FlutterShoppingPathRoutes.shoppingCart);
                    break;
                  case 3:
                    break;
                }
              },
            ),

            productBuilder: (context, product) => Card(
              elevation: 0,
              color: const Color.fromARGB(255, 233, 233, 233),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        product.imageUrl,
                        loadingBuilder: (context, child, loadingProgress) =>
                            loadingProgress == null
                                ? child
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                        errorBuilder: (context, error, stackTrace) =>
                            const Tooltip(
                          message: "Error loading image",
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: ColoredBox(
                      color: theme.scaffoldBackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: theme.textTheme.titleMedium,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Text(
                                  "4.5",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.blue,
                                  ),
                                ),
                                const Icon(Icons.star, color: Colors.orange),
                                const Icon(Icons.star, color: Colors.orange),
                                const Icon(Icons.star, color: Colors.orange),
                                const Icon(Icons.star, color: Colors.orange),
                                const Icon(Icons.star_half,
                                    color: Colors.orange),
                                Text(
                                  "(3)",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "\$${product.price.toStringAsFixed(2)}",
                              style: theme.textTheme.titleMedium,
                            ),
                            Text(
                              "Gratis bezorging door Amazon",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 12),
                            FilledButton(
                              onPressed: () {
                                productService.addProduct(product as MyProduct);
                              },
                              child: const Text("In winkelwagen"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // (RECOMMENDED) The shop that is initially selected.
            // Must be one of the shops in the [shops] list.
            initialShopId: getCategories().first.id,

            // (RECOMMENDED) Localizations for the product page.
            localizations: const ProductPageLocalization(),

            noContentBuilder: (context) => Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 128),
                child: Column(
                  children: [
                    const Icon(
                      Icons.warning,
                      size: 48,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Geen producten gevonden",
                      style: theme.textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),

            // (OPTIONAL) Appbar
            appBar: AppBar(
              title: const SizedBox(
                height: 40,
                child: SearchBar(
                  hintText: "Search products",
                  leading: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  trailing: [
                    Icon(
                      Icons.fit_screen_outlined,
                    ),
                  ],
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.go(homePage);
                },
              ),
              bottom: AppBar(
                backgroundColor: const Color.fromRGBO(203, 237, 230, 1),
                title: Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Bestemming: ${streetName ?? "Mark - 1234AB Doetinchem Nederland"}",
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                primary: false,
              ),
            ),
          ),

          // (OPTIONAL): Initial build shop id that overrides the initialShop
          initialBuildShopId: initialBuildShopId,
        );
      },

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
          onConfirmOrder: (products) => onCompleteShoppingCart(context),

          // (RECOMMENDED) localizations:
          localizations: const ShoppingCartLocalizations(),

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
      // onCompleteOrderDetails:
      //     (BuildContext context, OrderResult orderDetails) async {
      //   return true;
      // },
    );
