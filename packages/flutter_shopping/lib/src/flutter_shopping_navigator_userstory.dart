import "package:flutter/material.dart";
import "package:flutter_shopping/flutter_shopping.dart";

/// A userstory for the FlutterShoppingNavigator.
class FlutterShoppingNavigatorUserstory extends StatefulWidget {
  /// Constructor for the FlutterShoppingNavigatorUserstory.
  const FlutterShoppingNavigatorUserstory({
    this.options = const FlutterShoppingOptions(),
    this.translations = const ShoppingTranslations(),
    this.shoppingService,
    this.initialShopId,
    super.key,
  });

  /// The options for the shopping navigator.
  final FlutterShoppingOptions options;

  /// The shopping service.
  final ShoppingService? shoppingService;

  /// The translations.
  final ShoppingTranslations translations;

  /// The initial shop id.
  final String? initialShopId;

  @override
  State<FlutterShoppingNavigatorUserstory> createState() =>
      _FlutterShoppingNavigatorUserstoryState();
}

class _FlutterShoppingNavigatorUserstoryState
    extends State<FlutterShoppingNavigatorUserstory> {
  late ShoppingService shoppingService;

  @override
  void initState() {
    shoppingService = widget.shoppingService ?? ShoppingService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => shoppingScreen();

  Widget shoppingScreen() => ShoppingScreen(
        initialShopId: widget.initialShopId,
        translations: widget.translations,
        shoppingService: shoppingService,
        options: widget.options,
        onFilterPressed: () async {
          widget.options.onFilterPressed?.call() ?? await push(filterScreen());
        },
        onShoppingCartPressed: () async {
          widget.options.onCartPressed?.call() ??
              await push(shoppingCartScreen());
        },
      );

  Widget filterScreen() => FilterScreen(
        translations: widget.translations,
        shoppingService: shoppingService,
        options: widget.options,
      );

  Widget shoppingCartScreen() => ShoppingCartScreen(
        translations: widget.translations,
        shoppingService: shoppingService,
        options: widget.options,
        onOrder: () async {
          widget.options.onOrderPressed?.call() ??
              await push(personalInformationScreen());
        },
      );
  Widget personalInformationScreen() => PersonalInformationScreen(
        translations: widget.translations,
        options: widget.options,
        onFinished: (value) async {
          widget.options.getPersonalInformation?.call(value);
          widget.options.onPersonalInformationPressed?.call() ??
              await push(dateTimeInformationScreen());
        },
      );

  Widget dateTimeInformationScreen() => DateTimeInformationScreen(
        translations: widget.translations,
        onFinished: (value) async {
          widget.options.getDateTimeInformation?.call(value);
          widget.options.onDateTimePressed?.call() ??
              await push(paymentOptionsScreen());
        },
      );

  Widget paymentOptionsScreen() => PaymentOptionsScreen(
        translations: widget.translations,
        onFinished: (value) async {
          widget.options.getPaymentInformation?.call(value);
          widget.options.onPaymentPressed?.call() ?? await popUntil();
        },
      );

  Future<void> push(Widget screen) async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => screen));
  }

  Future<void> popUntil() async {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
