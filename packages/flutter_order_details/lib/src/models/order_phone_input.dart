import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_order_details/flutter_order_details.dart";

/// Order input for phone numbers with with predefined
/// text fields and validation.
class OrderPhoneInput extends OrderDetailInput<String> {
  /// Constructor for the phone input.
  OrderPhoneInput({
    required super.title,
    required super.outputKey,
    required this.textController,
    this.errorMustBe11Digits = "Number must be 11 digits (+31 6 XXXX XXXX)",
    this.errorMustStartWith316 = "Number must start with +316",
    this.errorMustBeNumeric = "Number must be numeric",
    super.errorIsRequired,
    super.subtitle,
    super.titleAlignment,
    super.titlePadding,
    super.titleStyle,
    super.isRequired,
    super.isReadOnly,
    super.initialValue,
  }) : super(
          validators: [
            (value) {
              if (value != null && value.length != 11) {
                return errorMustBe11Digits;
              }
              return null;
            },
            (value) {
              if (value != null && !value.startsWith("316")) {
                return errorMustStartWith316;
              }
              return null;
            },
            (value) {
              if (value != null && !RegExp(r"^\d+$").hasMatch(value)) {
                return errorMustBeNumeric;
              }
              return null;
            },
          ],
        );

  /// Text Controller for phone input.
  final TextEditingController textController;

  /// Error message that notifies the number must be 11 digits long.
  final String errorMustBe11Digits;

  /// Error message that notifies the number must start with +316
  final String errorMustStartWith316;

  /// Error message that notifies the number must be numeric.
  final String errorMustBeNumeric;

  @override
  Widget build(
    BuildContext context,
    String? buildInitialValue,
    Function({bool needsBlur}) onBlurBackground,
  ) {
    var theme = Theme.of(context);

    textController.text = initialValue ?? buildInitialValue ?? "31";
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
          prefixText: "+",
          prefixStyle: theme.textTheme.labelMedium,
          hintText: hint,
          filled: true,
          fillColor: theme.inputDecorationTheme.fillColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) => super.validate(value),
        readOnly: isReadOnly,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11), // international phone number
        ],
      ),
      onBlurBackground,
    );
  }
}
