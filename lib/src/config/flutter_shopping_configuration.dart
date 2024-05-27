import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";

/// Configuration class for the flutter_shopping user-story.
class FlutterShoppingConfiguration {
  /// Constructor for the FlutterShoppingConfiguration.
  const FlutterShoppingConfiguration({
    required this.shopBuilder,
    required this.shoppingCartBuilder,
    required this.onCompleteUserStory,
    this.orderDetailsBuilder,
    this.onCompleteOrderDetails,
    this.orderSuccessBuilder,
    this.orderFailedBuilder,
  });

  /// Builder for the shop/product page.
  final Widget Function(BuildContext context) shopBuilder;

  /// Builder for the shopping cart page.
  final Widget Function(BuildContext context) shoppingCartBuilder;

  /// Function that is called when the user-story is completed.
  final Function(BuildContext context) onCompleteUserStory;

  /// Builder for the order details page. This does not have to be set if you
  /// are using the default order details page.
  final Widget Function(BuildContext context)? orderDetailsBuilder;

  /// Allows you to execute actions before
  final Future<bool> Function(BuildContext context, OrderResult result)?
      onCompleteOrderDetails;

  /// Builder for when the order is successful.
  final Widget Function(BuildContext context)? orderSuccessBuilder;

  /// Builder for when the order failed.
  final Widget Function(BuildContext context)? orderFailedBuilder;
}
