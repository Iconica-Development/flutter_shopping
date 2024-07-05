import "package:flutter/material.dart";
import "package:flutter_shopping_cart/flutter_shopping_cart.dart";

/// Shopping cart screen widget.
class ShoppingCartScreen extends StatelessWidget {
  /// Creates a shopping cart screen.
  const ShoppingCartScreen({
    required this.configuration,
    super.key,
  });

  /// Configuration for the shopping cart screen.
  final ShoppingCartConfig configuration;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: configuration.appBar?.call(context),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: configuration.pagePadding!,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (configuration.titleBuilder != null) ...{
                      configuration.titleBuilder!(
                        context,
                        configuration.translations!.cartTitle,
                      ),
                    } else ...{
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 32,
                        ),
                        child: Row(
                          children: [
                            Text(
                              configuration.translations!.cartTitle,
                              style: theme.textTheme.titleLarge,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    },
                    ListenableBuilder(
                      listenable: configuration.service,
                      builder: (context, _) => Column(
                        children: [
                          for (var product in configuration.service.products)
                            configuration.productItemBuilder!(
                              context,
                              product,
                              configuration,
                            ),

                          // Additional whitespace at
                          // the bottom to make sure the last
                          // product(s) are not hidden by the bottom sheet.
                          SizedBox(
                            height: configuration.confirmOrderButtonHeight! +
                                configuration.sumBottomSheetHeight!,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _BottomSheet(
                configuration: configuration,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomSheet extends StatelessWidget {
  const _BottomSheet({
    required this.configuration,
  });

  final ShoppingCartConfig configuration;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListenableBuilder(
            listenable: configuration.service,
            builder: (BuildContext context, Widget? child) =>
                configuration.sumBottomSheetBuilder!(context, configuration),
          ),
          ListenableBuilder(
            listenable: configuration.service,
            builder: (context, _) => configuration.confirmOrderButtonBuilder!(
              context,
              configuration,
              configuration.onConfirmOrder,
            ),
          ),
        ],
      );
}
