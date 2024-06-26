import "package:flutter/material.dart";
import "package:flutter_order_details/src/configuration/order_detail_title_style.dart";

/// Abstract class for order detail input.
/// Each input field must extend from this class.
abstract class OrderDetailInput<T> {
  /// Constructor for the order detail input.
  OrderDetailInput({
    required this.title,
    required this.outputKey,
    this.titleStyle = OrderDetailTitleStyle.text,
    this.titleAlignment = Alignment.centerLeft,
    this.titlePadding = const EdgeInsets.symmetric(vertical: 4),
    this.subtitle,
    this.isRequired = true,
    this.isReadOnly = false,
    this.initialValue,
    this.validators = const [],
    this.onValueChanged,
    this.hint,
    this.errorIsRequired = "This field is required",
    this.paddingBetweenFields = const EdgeInsets.symmetric(vertical: 4),
  });

  /// Title of the input field.
  final String title;

  /// Subtitle of the input field.
  final String? subtitle;

  /// The styling for the title.
  final OrderDetailTitleStyle titleStyle;

  /// The alignment of the titl
  final Alignment titleAlignment;

  /// Padding around the title.
  final EdgeInsets titlePadding;

  /// The output key of the input field.
  final String outputKey;

  /// Hint message of the input field.
  final String? hint;

  /// Determines if the input field is required.
  final bool isRequired;

  /// Error message for when an user does not insert something in the field
  /// even though it is required.
  final String errorIsRequired;

  /// A read-only field that users cannot change.
  final bool isReadOnly;

  /// An initial value for the input field. This is ideal incombination
  /// with the [isReadOnly] field.
  final T? initialValue;

  /// Internal current value. Do not use.
  T? currentValue;

  /// List of validators that should be executed when the input field
  /// is validated.
  List<String? Function(T?)> validators;

  /// Function that is called when the value of the input field changes.
  final Function(T)? onValueChanged;

  /// Padding between the fields.
  final EdgeInsets paddingBetweenFields;

  /// Allows you to update the current value.
  @protected
  set updateValue(T value) {
    currentValue = value;
  }

  /// Function that validates the input field. Automatically keeps track
  /// of the [isRequired] keys and all the custom validators.
  @protected
  String? validate(T? value) {
    if (isRequired && (value == null || value.toString().isEmpty)) {
      return errorIsRequired;
    }

    for (var validator in validators) {
      var error = validator(value);
      if (error != null) {
        return error;
      }
    }

    return null;
  }

  /// Builds the basic outline of an input field.
  @protected
  Widget buildOutline(
    BuildContext context,
    // ignore: avoid_annotating_with_dynamic
    dynamic child,
    Function({bool needsBlur}) onBlurBackground,
  ) {
    var theme = Theme.of(context);

    return Column(
      children: [
        if (titleStyle == OrderDetailTitleStyle.text) ...[
          Align(
            alignment: titleAlignment,
            child: Padding(
              padding: titlePadding,
              child: Text(
                title,
                style: theme.textTheme.titleMedium,
              ),
            ),
          ),
          if (subtitle != null) ...[
            Padding(
              padding: titlePadding,
              child: Align(
                alignment: titleAlignment,
                child: Text(
                  subtitle!,
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ),
          ],
        ],
        if (child is FormField || child is Widget) ...[
          child,
        ] else if (child is List<FormField>) ...[
          Column(
            children: child
                .map(
                  (FormField field) => Padding(
                    padding: paddingBetweenFields,
                    child: field,
                  ),
                )
                .toList(),
          ),
        ] else if (child is List<OrderDetailInput>) ...[
          Column(
            children: child
                .map(
                  (OrderDetailInput input) => Padding(
                    padding: paddingBetweenFields,
                    child: input.build(
                      context,
                      input.initialValue,
                      onBlurBackground,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }

  /// Abstract build function that each orderinput class must implement
  /// themsleves. For a basic layout, they can use the [buildOutline] function.
  Widget build(
    BuildContext context,
    T? buildInitialValue,
    Function({bool needsBlur}) onBlurBackground,
  );
}
