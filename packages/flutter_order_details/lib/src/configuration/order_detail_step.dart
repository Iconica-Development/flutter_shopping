import "package:flutter/widgets.dart";
import "package:flutter_order_details/flutter_order_details.dart";

/// Configuration for the order detail step.
class OrderDetailStep {
  /// Constructor for the order detail step.
  OrderDetailStep({
    required this.formKey,
    required this.fields,
    this.stepName,
  });

  /// Optional name for the step.
  final String? stepName;

  /// Form key for the step.
  final GlobalKey<FormState> formKey;

  /// List of fields that the user has to fill in.
  /// Each field must extend from the `OrderDetailInput` class.
  final List<OrderDetailInput> fields;
}
