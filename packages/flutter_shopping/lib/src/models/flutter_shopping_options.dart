import "package:flutter/material.dart";
import "package:shopping_repository_interface/shopping_repository_interface.dart";

/// The options for the flutter shopping package.
class FlutterShoppingOptions {
  /// The constructor for the FlutterShoppingOptions.
  const FlutterShoppingOptions({
    this.shoppingScreenAppbarBuilder,
    this.filterChipbuilder,
    this.weeklyOfferBuilder,
    this.productItemBuilder,
    this.primaryButtonBuilder,
    this.shopSelectorItemBuilder,
    this.filterScreenAppbarBuilder,
    this.filterItemBuilder,
    this.shoppingCartItemBuilder,
    this.onInfoPressed,
    this.informationInputDecoration,
    this.onFilterPressed,
    this.onCartPressed,
    this.onOrderPressed,
    this.onPersonalInformationPressed,
    this.onDateTimePressed,
    this.onPaymentPressed,
    this.shoppingScreenDrawer,
    this.getPersonalInformation,
    this.getDateTimeInformation,
    this.getPaymentInformation,
  });

  /// The appbar builder for the shopping screen.
  final AppBarBuilder? shoppingScreenAppbarBuilder;

  /// The weekly offer builder for the shopping screen.
  final ItemBuilder? weeklyOfferBuilder;

  /// The product item builder for the shopping screen.
  final ItemBuilder? productItemBuilder;

  /// The filter chip builder for the shopping screen.
  final Widget? Function(
    BuildContext context,
    String title,
    Function() onDelete,
  )? filterChipbuilder;

  /// The primary button builder.
  final Widget Function(
    BuildContext context,
    // ignore: avoid_positional_boolean_parameters
    bool enabled,
    String title,
    Function() onPressed,
  )? primaryButtonBuilder;

  /// shop selector item builder.
  final Widget Function(
    BuildContext context,
    Shop shop,
    Function(Shop) onSelected,
  )? shopSelectorItemBuilder;

  /// The appbar builder for the filter screen.
  final AppBarBuilder? filterScreenAppbarBuilder;

  /// The filter item builder.
  final Widget Function(
    BuildContext context,
    Function() onDeselect,
    Function() onSelect,
    // ignore: avoid_positional_boolean_parameters
    bool currentValue,
  )? filterItemBuilder;

  /// The shopping cart item builder.
  final Widget Function(
    BuildContext context,
    Product product,
    Function() onAddToCart,
    Function() onRemoveFromCart,
  )? shoppingCartItemBuilder;

  /// The on info pressed function.
  final Function(Product product)? onInfoPressed;

  /// The input decoration for the information.
  final InputDecoration? Function(BuildContext context, String hintText)?
      informationInputDecoration;

  /// on filter pressed.
  final Function()? onFilterPressed;

  /// on cart pressed.
  final Function()? onCartPressed;

  /// on order pressed.
  final Function()? onOrderPressed;

  /// on personal information pressed.
  final Function()? onPersonalInformationPressed;

  /// on address pressed.
  final Function()? onDateTimePressed;

  /// on payment pressed.
  final Function()? onPaymentPressed;

  /// The shopping screen drawer.
  final Widget? shoppingScreenDrawer;

  /// The function to get the personal information.
  final Function(Map<String, dynamic> value)? getPersonalInformation;

  /// The function to get the address information.
  final Function(Map<String, dynamic> value)? getDateTimeInformation;

  /// The function to get the payment information.
  final Function(Map<String, dynamic> value)? getPaymentInformation;
}

/// The appbar builder.
typedef AppBarBuilder = AppBar Function(
  BuildContext context,
  String title,
  Function()? onFilterPressed,
);

/// The item builder.
typedef ItemBuilder = Widget Function(
  BuildContext context,
  Product product,
);
