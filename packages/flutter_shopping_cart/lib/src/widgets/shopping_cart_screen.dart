import "package:flutter/material.dart";
import "package:flutter_shopping_cart/flutter_shopping_cart.dart";

/// Shopping cart screen widget.
class ShoppingCartScreen<T extends ShoppingCartProduct>
    extends StatelessWidget {
  /// Creates a shopping cart screen.
  const ShoppingCartScreen({
    required this.configuration,
    super.key,
  });

  /// Configuration for the shopping cart screen.
  final ShoppingCartConfig<T> configuration;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var productBuilder = SingleChildScrollView(
      child: Column(
        children: [
          if (configuration.titleBuilder != null) ...{
            configuration.titleBuilder!(context),
          } else if (configuration.title != null) ...{
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                configuration.title!,
                style: theme.textTheme.titleLarge,
              ),
            ),
          },
          ListenableBuilder(
            listenable: configuration.productService,
            builder: (context, _) {
              var products = configuration.productService.products;

              if (products.isEmpty) {
                return configuration.noContentBuilder(context);
              }

              return Column(
                children: [
                  for (var product in products)
                    configuration.productItemBuilder(
                      context,
                      configuration.localizations.locale,
                      product,
                    ),
                  // Additional whitespace at the bottom to make sure the
                  // last product(s) are not hidden by the bottom sheet.
                  SizedBox(
                    height: configuration.confirmOrderButtonHeight +
                        configuration.sumBottomSheetHeight,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    var bottomHeight = configuration.confirmOrderButtonHeight +
        configuration.sumBottomSheetHeight;

    var bottomBlur = Container(
      height: bottomHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.surface.withOpacity(0),
            theme.colorScheme.surface.withOpacity(.5),
            theme.colorScheme.surface.withOpacity(.8),
            theme.colorScheme.surface.withOpacity(.8),
            theme.colorScheme.surface.withOpacity(.8),
            theme.colorScheme.surface.withOpacity(.8),
            theme.colorScheme.surface.withOpacity(1),
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: configuration.appBar,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: configuration.padding,
            child: productBuilder,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: bottomBlur,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _BottomSheet<T>(
              configuration: configuration,
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomSheet<T extends ShoppingCartProduct> extends StatelessWidget {
  const _BottomSheet({
    required this.configuration,
    super.key,
  });

  final ShoppingCartConfig<T> configuration;

  @override
  Widget build(BuildContext context) {
    var placeOrderButton = ListenableBuilder(
      listenable: configuration.productService,
      builder: (BuildContext context, Widget? child) =>
          configuration.confirmOrderButtonBuilder != null
              ? configuration.confirmOrderButtonBuilder!(context)
              : _DefaultConfirmOrderButton<T>(configuration: configuration),
    );

    var bottomSheet = ListenableBuilder(
      listenable: configuration.productService,
      builder: (BuildContext context, Widget? child) =>
          configuration.sumBottomSheetBuilder != null
              ? configuration.sumBottomSheetBuilder!(context)
              : _DefaultSumBottomSheet(configuration: configuration),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        bottomSheet,
        placeOrderButton,
      ],
    );
  }
}

class _DefaultConfirmOrderButton<T extends ShoppingCartProduct>
    extends StatelessWidget {
  const _DefaultConfirmOrderButton({
    required this.configuration,
  });

  final ShoppingCartConfig<T> configuration;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    void onConfirmOrderPressed(List<T> products) {
      if (configuration.onConfirmOrder == null) {
        return;
      }

      if (products.isEmpty) {
        return;
      }

      configuration.onConfirmOrder!(products);
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
          ),
          onPressed: () => onConfirmOrderPressed(
            configuration.productService.products,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              """${configuration.localizations.placeOrder} (${configuration.productService.countProducts()})""",
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DefaultSumBottomSheet extends StatelessWidget {
  const _DefaultSumBottomSheet({
    required this.configuration,
  });

  final ShoppingCartConfig configuration;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var totalPrice = configuration.productService.products
        .map((product) => product.price * product.quantity)
        .fold(0.0, (a, b) => a + b);

    return Padding(
      padding: configuration.bottomPadding,
      child: Row(
        children: [
          Text(
            configuration.localizations.sum,
            style: theme.textTheme.titleMedium,
          ),
          const Spacer(),
          Text(
            totalPrice.toStringAsFixed(2),
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
