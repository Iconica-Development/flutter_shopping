# Flutter Shopping

Flutter Shopping is a package that allows you to create a shopping experience in your Flutter app.
By default, it uses a `ShoppingService` with a local implementation ,it provides a simple shopping 
experience with a list of products and a shopping cart. You can implement your own `ShoppingService` by overriding the `shopRepository`, `cartRepository`, `categoryRepository` and `orderRepository` properties.

## Setup

To use this package, add flutter_shopping as a dependency in your pubspec.yaml file:

```
  flutter_chat:
    git:
      url: https://github.com/Iconica-Development/flutter_shopping
      path: packages/flutter_shopping
```

If you are going to use Firebase as the back-end of flutter_shopping, you should also add the following package as a dependency to your pubspec.yaml file:

```
  firebase_shopping_repository:
    git:
      url: https://github.com/Iconica-Development/flutter_shopping
      path: packages/firebase_shopping_repository
```

Create a Firebase project for your application and add firebase firestore and storage.

make sure you are authenticated using the `Firebase_auth` package or adjust your firebase rules, otherwise you won't be able to retreive data.

Also make sure you have the corresponding collections in your firebase project as defined in the `FirebaseRepositories`, you can override the
default paths as you wish:

``` dart
  FirebaseCategoryRepository({
    this.collectionName = 'shopping_category',
  });

 FirebaseCartRepository({
    this.collectionName = 'shopping_cart',
  });   

 FirebaseOrderRepository({
    this.collectionName = 'shopping_order',
  });
```

Also the structure of your data should be equal to our predefined models.

## How to use

To use this package, add the following widget `FlutterShoppingNavigatorUserstory` to your widget tree:

``` dart
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
```

All of the properties are optional.

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/Iconica-Development/flutter_shopping/pulls) page. Commercial support is available if you need help with integration with your app or services. You can contact us at [support@iconica.nl](mailto:support@iconica.nl).

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](./CONTRIBUTING.md) and send us your [pull request](https://github.com/Iconica-Development/flutter_shopping/pulls).

## Author

This `flutter_shopping` for Flutter is developed by [Iconica](https://iconica.nl). You can contact us at <support@iconica.nl>