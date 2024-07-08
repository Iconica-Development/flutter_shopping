import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// Configuration for the order detail screen.
class OrderDetailConfiguration {
  /// Constructor for the order detail configuration.
  const OrderDetailConfiguration({
    required this.shoppingService,
    required this.onNextStep,
    required this.onStepsCompleted,
    required this.onCompleteOrderDetails,
    this.pages,
    this.translations = const OrderDetailTranslations(),
    this.appBarBuilder,
    this.nextbuttonBuilder,
    this.orderSuccessBuilder,
  });

  /// The shopping service that is used
  final ShoppingService shoppingService;

  /// The different steps that the user has to go through to complete the order.
  /// Each step contains a list of fields that the user has to fill in.
  final List<FlutterFormPage> Function(BuildContext context)? pages;

  /// Callback function that is called when the user has completed the order.
  /// The result of the order is passed as an argument to the function.
  final Function(
    String shopId,
    List<Product> products,
    Map<int, Map<String, dynamic>> value,
    OrderDetailConfiguration configuration,
  ) onStepsCompleted;

  /// Callback function that is called when the user has completed a step.
  final Function(
    int currentStep,
    Map<String, dynamic> data,
    FlutterFormController controller,
  ) onNextStep;

  /// Localization for the order detail screen.
  final OrderDetailTranslations translations;

  /// Optional app bar that you can pass to the order detail screen.
  final PreferredSizeWidget? Function(BuildContext context, String title)?
      appBarBuilder;

  /// Optional next button builder that you can pass to the order detail screen.
  final Widget Function(
    int currentStep,
    // ignore: avoid_positional_boolean_parameters
    bool checkingPages,
    BuildContext context,
    OrderDetailConfiguration configuration,
    FlutterFormController controller,
  )? nextbuttonBuilder;

  /// Optional builder for the order success screen.
  final Widget Function(
    BuildContext context,
    OrderDetailConfiguration,
    Map<int, Map<String, dynamic>> orderDetails,
  )? orderSuccessBuilder;

  /// This function is called after the order has been completed and
  /// the success screen has been shown.
  final Function(BuildContext context, OrderDetailConfiguration configuration)
      onCompleteOrderDetails;
}
