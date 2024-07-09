import "package:flutter/material.dart";
import "package:flutter_shopping_cart/flutter_shopping_cart.dart";
import "package:flutter_shopping_cart/src/widgets/default_appbar.dart";
import "package:flutter_shopping_cart/src/widgets/default_confirm_order_button.dart";
import "package:flutter_shopping_cart/src/widgets/default_shopping_cart_item.dart";
import "package:flutter_shopping_cart/src/widgets/default_sum_bottom_sheet_builder.dart";

/// Shopping cart screen widget.
class ShoppingCartScreen extends StatefulWidget {
  /// Creates a shopping cart screen.
  const ShoppingCartScreen({
    required this.configuration,
    super.key,
  });

  /// Configuration for the shopping cart screen.
  final ShoppingCartConfig configuration;

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: widget.configuration.appBarBuilder?.call(context) ??
          const DefaultAppbar(),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: widget.configuration.pagePadding,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (widget.configuration.titleBuilder != null) ...{
                      widget.configuration.titleBuilder!(
                        context,
                        widget.configuration.translations.cartTitle,
                      ),
                    } else ...{
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 32,
                        ),
                        child: Row(
                          children: [
                            Text(
                              widget.configuration.translations.cartTitle,
                              style: theme.textTheme.titleLarge,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                    },
                    Column(
                      children: [
                        for (var product
                            in widget.configuration.service.products)
                          widget.configuration.productItemBuilder?.call(
                                context,
                                product,
                                widget.configuration,
                              ) ??
                              DefaultShoppingCartItem(
                                product: product,
                                configuration: widget.configuration,
                                onItemAddedRemoved: () {
                                  setState(() {});
                                },
                              ),

                        // Additional whitespace at
                        // the bottom to make sure the last
                        // product(s) are not hidden by the bottom sheet.
                        SizedBox(
                          height:
                              widget.configuration.confirmOrderButtonHeight +
                                  widget.configuration.sumBottomSheetHeight,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _BottomSheet(
                configuration: widget.configuration,
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
          configuration.sumBottomSheetBuilder?.call(context, configuration) ??
              DefaultSumBottomSheetBuilder(
                configuration: configuration,
              ),
          configuration.confirmOrderButtonBuilder?.call(
                context,
                configuration,
                configuration.onConfirmOrder,
              ) ??
              DefaultConfirmOrderButton(
                configuration: configuration,
                onConfirmOrder: configuration.onConfirmOrder,
              ),
        ],
      );
}
