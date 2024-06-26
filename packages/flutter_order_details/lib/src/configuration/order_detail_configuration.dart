import "package:flutter/widgets.dart";
import "package:flutter_order_details/src/configuration/order_detail_localization.dart";
import "package:flutter_order_details/src/configuration/order_detail_step.dart";
import "package:flutter_order_details/src/models/order_result.dart";

/// Configuration for the order detail screen.
class OrderDetailConfiguration {
  /// Constructor for the order detail configuration.
  const OrderDetailConfiguration({
    required this.steps,
    //
    required this.onCompleted,
    //
    this.progressIndicator = true,
    //
    this.localization = const OrderDetailLocalization(),
    //
    this.inputFieldPadding = const EdgeInsets.symmetric(
      horizontal: 32,
      vertical: 16,
    ),
    this.titlePadding = const EdgeInsets.only(left: 16, right: 16, top: 16),
    //
    this.appBar,
  });

  /// The different steps that the user has to go through to complete the order.
  /// Each step contains a list of fields that the user has to fill in.
  final List<OrderDetailStep> steps;

  /// Callback function that is called when the user has completed the order.
  /// The result of the order is passed as an argument to the function.
  final Function(OrderResult result) onCompleted;

  /// Whether or not you want to show a progress indicator at
  /// the top of the screen.
  final bool progressIndicator;

  /// Localization for the order detail screen.
  final OrderDetailLocalization localization;

  /// Padding around the input fields.
  final EdgeInsets inputFieldPadding;

  /// Padding around the title of the input fields.
  final EdgeInsets titlePadding;

  /// Optional app bar that you can pass to the order detail screen.
  final PreferredSizeWidget? appBar;
}
