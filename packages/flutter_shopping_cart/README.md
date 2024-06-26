# flutter_shopping_cart

This component contains a shopping cart screen and the functionality for shopping carts that contain products.

## Features

* Shopping cart screen
* Shopping cart products

## Usage

First, create your own product by extending the `Product` class:

```dart
class ExampleProduct extends Product {
  ExampleProduct({
    requried super.id,
    required super.name,
    required super.price,
    required this.image,
    super.quantity,
  });

  final String image;
}
```

Next, you can create the `ShoppingCartScreen` widget like this:

```dart
var myProductService = ProductService<ExampleProduct>([]);

ShoppingCartScreen<ExampleProduct>(
    configuration: ShoppingCartConfig<ExampleProduct>(
        productService: myProductService,
        //
        productItemBuilder: (
            BuildContext context,
            Locale locale,
            ExampleProduct product,
        ) =>
            ListTile(
            title: Text(product.name),
            subtitle: Text(product.price.toString()),
        ),
        //
        onConfirmOrder: (List<ExampleProduct> products) {
            print("Placing order with products: $products");
        },
    ),
);
```

For a more detailed example you can see the [example](https://github.com/Iconica-Development/flutter_shopping_cart/tree/main/example).

Or, you could run the example yourself:
```
git clone https://github.com/Iconica-Development/flutter_shopping_cart.git

cd flutter_shopping_cart

cd example

flutter run
```

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_shopping_cart) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute

If you would like to contribute to the component (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_shopping_cart/pulls).

## Author

This flutter_shopping_cart for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>
