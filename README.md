# flutter_shopping

The flutter_shopping user-story allows you to create an user shopping flow within minutes of work. This user-story contains the ability to show products, shopping cart, gathering user information and order succes and failed screens.

## Setup

(1) Set up your `MyShop` model by extending from the `ProductPageShop` class. The most basic version looks like this:

```dart
class MyShop extends ProductPageShop {
  const MyShop({
    required super.id,
    required super.name,
  });
}
```

(2) Set up your `MyProduct` model by extending from `ShoppingCartProduct` and extending from the mixin `ProductPageProduct`, like this:

```dart
class MyProduct extends ShoppingCartProduct with ProductPageProduct {
  MyProduct({
    required super.id,
    required super.name,
    required super.price,
    required this.category,
    required this.imageUrl,
    this.discountPrice,
    this.hasDiscount = false,
  });

  @override
  final String category;

  @override
  final String imageUrl;

  @override
  final double? discountPrice;

  @override
  final bool hasDiscount;
}
```

(3) Finally in your `routes.dart` import all the routes from the user-story:

```dart
...getShoppingStoryRoutes(
    configuration: ...
),  
```

(4) Create a new instantiation of the ProductService class:

```dart
final ProductService<MyProduct> productService = ProductService([]);
```

(5) Set up the `FlutterShoppingConfiguration`:

```dart
FlutterShoppingConfiguration(
    // (REQUIRED): Shop builder configuration
    shopBuilder: (BuildContext context) => ProductPageScreen(
        configuration: ProductPageConfiguration(
            // (REQUIRED): List of shops that should be displayed
            // If there is only one, make a list with just one shop.
            shops: getShops(),

            // (REQUIRED): Function to add a product to the cart
            onAddToCart: (ProductPageProduct product) =>
                productService.addProduct(product as MyProduct),

            // (REQUIRED): Function to get the products for a shop
            getProducts: (String shopId) => Future<ProductPageContent>.value(
                getShopContent(shopId),
            ),

            // (REQUIRED): Function to navigate to the shopping cart
            onNavigateToShoppingCart: () => onCompleteProductPage(context),

            // (RECOMMENDED) Function that returns the description for a
            // product that is on sale.
            getDiscountDescription: (ProductPageProduct product) =>
                """${product.name} for just \$${product.discountPrice?.toStringAsFixed(2)}""",

            // (RECOMMENDED) Function that is fired when the shop selection
            // changes. You could use this to clear your shopping cart or to
            // change the products so they belong to the correct shop again.
            onShopSelectionChange: (ProductPageShop shop) => productService.clear(),

            // (RECOMMENDED) The shop that is initially selected.
            // Must be one of the shops in the [shops] list.
            initialShop: getShops().first,

            // (RECOMMENDED) Localizations for the product page.
            localizations: const ProductPageLocalization(),

            // (OPTIONAL) Appbar
            appBar: ...
        ),
    ),

    // (REQUIRED): Shopping cart builder configuration
    shoppingCartBuilder: (BuildContext context) => ShoppingCartScreen(
        configuration: ShoppingCartConfig(
            // (REQUIRED) product service instance:
            productService: productService,

            // (REQUIRED) product item builder:
            productItemBuilder: (context, locale, product) => ...

            // (OPTIONAL/REQUIRED) on confirm order callback:
            // Either use this callback or the placeOrderButtonBuilder.
            onConfirmOrder: (products) => onCompleteShoppingCart(context),

            // (RECOMMENDED) localizations:
            localizations: const ShoppingCartLocalizations(),

            // (OPTIONAL) custom appbar:
            appBar: ...
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
            ...
    },
)
```

For more information about the component specific items please take a look at their repositories:

- [flutter_product_page](https://github.com/Iconica-Development/flutter_product_page/)
- [flutter_shopping_cart](https://github.com/Iconica-Development/flutter_shopping_cart)
- [flutter_order_details](https://github.com/Iconica-Development/flutter_order_details)

## Usage

For a detailed example you can see the [example](https://github.com/Iconica-Development/flutter_shopping/tree/main/example).

Or, you could run the example yourself:
```
git clone https://github.com/Iconica-Development/flutter_shopping.git

cd flutter_shopping

cd example

flutter run
```

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_shopping) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute

If you would like to contribute to the component (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_shopping/pulls).

## Author

This flutter_shopping for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>
