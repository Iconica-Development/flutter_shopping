import "package:flutter/material.dart";
import "package:flutter_shopping_cart/flutter_shopping_cart.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// Shopping cart configuration
///
/// This class is used to configure the shopping cart.
class ShoppingCartConfig {
  /// Creates a shopping cart configuration.
  ShoppingCartConfig({
    required this.service,
    required this.onConfirmOrder,
    this.productItemBuilder,
    this.confirmOrderButtonBuilder,
    this.confirmOrderButtonHeight = 100,
    this.sumBottomSheetBuilder,
    this.sumBottomSheetHeight = 100,
    this.titleBuilder,
    this.translations = const ShoppingCartTranslations(),
    this.pagePadding = const EdgeInsets.symmetric(horizontal: 32),
    this.bottomPadding = const EdgeInsets.fromLTRB(44, 0, 44, 32),
    this.appBarBuilder,
  });

  /// Product service. The product service is used to manage the products in the
  /// shopping cart.
  final ShoppingCartService service;

  /// Product item builder. This builder is used to build the product item
  /// that will be displayed in the shopping cart.
  Widget Function(
    BuildContext context,
    Product product,
    ShoppingCartConfig configuration,
  )? productItemBuilder;

  /// Confirm order button builder. This builder is used to build the confirm
  /// order button that will be displayed in the shopping cart.
  /// If you override this builder, you cannot use the [onConfirmOrder] callback
  Widget Function(
    BuildContext context,
    ShoppingCartConfig configuration,
    Function(List<Product> products) onConfirmOrder,
  )? confirmOrderButtonBuilder;

  /// Confirm order button height. The height of the confirm order button.
  /// This height is used to calculate the bottom padding of the shopping cart.
  /// If you override the confirm order button builder, you must provide a
  /// height.
  double confirmOrderButtonHeight;

  /// Confirm order callback. This callback is called when the confirm order
  /// button is pressed. The callback will not be called if you override the
  /// confirm order button builder.
  final Function(List<Product> products) onConfirmOrder;

  /// Sum bottom sheet builder. This builder is used to build the sum bottom
  /// sheet that will be displayed in the shopping cart. The sum bottom sheet
  /// can be used to display the total sum of the products in the shopping cart.
  Widget Function(BuildContext context, ShoppingCartConfig configuration)?
      sumBottomSheetBuilder;

  /// Sum bottom sheet height. The height of the sum bottom sheet.
  /// This height is used to calculate the bottom padding of the shopping cart.
  /// If you override the sum bottom sheet builder, you must provide a height.
  double sumBottomSheetHeight;

  /// Padding around the shopping cart. The padding is used to create space
  /// around the shopping cart.
  EdgeInsets pagePadding;

  /// Bottom padding of the shopping cart. The bottom padding is used to create
  /// a padding around the bottom sheet. This padding is ignored when the
  /// [sumBottomSheetBuilder] is overridden.
  EdgeInsets bottomPadding;

  /// Title builder. This builder is used to
  /// build the title of the shopping cart.
  final Widget Function(
    BuildContext context,
    String title,
  )? titleBuilder;

  /// Shopping cart translations. The translations for the shopping cart.
  ShoppingCartTranslations translations;

  /// Appbar for the shopping cart screen.
  PreferredSizeWidget Function(BuildContext context)? appBarBuilder;
}
