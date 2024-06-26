# flutter_product_page

This component allows you to easily create and manage the products for any shop. Easily highlight a specific product
and automatically see your products categorized. This package allows users to gather more information about a product,
add it to a custom implementable shopping cart and even navigate to your own shopping cart.

This component is very customizable, it allows you to adjust basically everything while providing clean defaults.

## Features

* Easily navigate between different shops,
* Show users a highlighted product,
* Integrate with your own shopping cart,
* Automatically categorized products, powered by the `flutter_nested_categories` package that you have full control over, even in this component.

## Usage

First, you must implement your own `Shop` and `Product` classes. Your shop class must extend from the `ProductPageShop` class provided by this module. Your `Product` class should extend from the `Product` class provided by this module. 

Next, you can create a `ProductPage` or a `ProductPageScreen`. The choice for the former is when you do not want to create a new Scaffold and the latter for when you want to create a new Scaffold.

To show the page, you must configure what you want to show. Both the `ProductPage` and the `ProductPageScreen` take a parameter that is a `ProductPageConfiguration`. This allows you for a lot of customizability, including what shops there are and what products to show.

For a more detailed example you can see the [example](https://github.com/Iconica-Development/flutter_product_page/tree/main/example).

Or, you could run the example yourself:
```
git clone https://github.com/Iconica-Development/flutter_product_page.git

cd flutter_product_page

cd example

flutter run
```

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_product_page) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute

If you would like to contribute to the component (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_product_page/pulls).

## Author

This flutter_product_page for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>
