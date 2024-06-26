import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";

/// Order Email input with predefined validators.
class OrderEmailInput extends OrderDetailInput<String> {
  /// Constructor of the order email input.
  OrderEmailInput({
    required super.title,
    required super.outputKey,
    required this.textController,
    super.titleStyle,
    super.titleAlignment,
    super.titlePadding,
    super.subtitle,
    super.hint,
    super.errorIsRequired,
    super.isRequired,
    super.isReadOnly,
    super.initialValue,
    this.errorInvalidEmail = "Invalid email ( your_name@example.com )",
  }) : super(
          validators: [
            (value) {
              if (value != null && !RegExp(r"^\w+@\w+\.\w+$").hasMatch(value)) {
                return errorInvalidEmail;
              }
              return null;
            },
          ],
        );

  /// Text Controller for email input.
  final TextEditingController textController;

  /// Error message for invalid email.
  final String errorInvalidEmail;

  @override
  Widget build(
    BuildContext context,
    String? buildInitialValue,
    Function({bool needsBlur}) onBlurBackground,
  ) {
    var theme = Theme.of(context);

    textController.text = initialValue ?? buildInitialValue ?? "";
    currentValue = textController.text;

    return buildOutline(
      context,
      TextFormField(
        style: theme.textTheme.labelMedium,
        controller: textController,
        onChanged: (String value) {
          currentValue = value;
          super.onValueChanged?.call(value);
        },
        decoration: InputDecoration(
          labelText: titleStyle == OrderDetailTitleStyle.label ? title : null,
          hintText: hint,
          filled: true,
          fillColor: theme.inputDecorationTheme.fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) => super.validate(value),
        keyboardType: TextInputType.emailAddress,
        readOnly: isReadOnly,
      ),
      onBlurBackground,
    );
  }
}
