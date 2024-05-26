import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";

/// TODO
class FlutterShoppingConfiguration {
  /// TODO
  const FlutterShoppingConfiguration({
    required this.shopBuilder,
    required this.shoppingCartBuilder,
    required this.onCompleteUserStory,
    this.showOrderDetails = false,
    this.orderDetailsBuilder,
    this.onCompleteOrderDetails,
    this.orderSuccessBuilder,
    this.orderFailedBuilder,
  }) : assert(
          showOrderDetails && orderDetailsBuilder != null ||
              !showOrderDetails && orderDetailsBuilder == null,
          "showOrderDetails and orderDetailsBuilder must be both set or unset.",
        );

  /// TODO
  final Widget Function(BuildContext context) shopBuilder;

  /// TODO
  final Widget Function(BuildContext context) shoppingCartBuilder;

  /// TODO
  final Function(BuildContext context) onCompleteUserStory;

  /// TODO
  final bool showOrderDetails;

  /// TODO
  final Widget Function(BuildContext context)? orderDetailsBuilder;

  /// Allows you to execute actions before
  final Future<bool> Function(BuildContext context, OrderResult result)?
      onCompleteOrderDetails;

  /// TODO
  final Widget Function(BuildContext context)? orderSuccessBuilder;

  /// TODO
  final Widget Function(BuildContext context)? orderFailedBuilder;
}
