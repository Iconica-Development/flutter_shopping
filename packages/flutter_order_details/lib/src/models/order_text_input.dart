import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_order_details/flutter_order_details.dart";

/// Default text input for order details.
class OrderTextInput extends OrderDetailInput<String> {
  /// Default text input for order details.
  OrderTextInput({
    required super.title,
    required super.outputKey,
    required this.textController,
    super.titleStyle,
    super.titleAlignment,
    super.titlePadding,
    super.subtitle,
    super.isRequired,
    super.isReadOnly,
    super.initialValue,
    super.validators,
    super.onValueChanged,
    super.errorIsRequired,
    super.hint,
    this.inputFormatters = const [],
  });

  /// Text Controller for the input field.
  final TextEditingController textController;

  /// List of input formatters for the text field.
  final List<TextInputFormatter> inputFormatters;

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
        validator: super.validate,
        readOnly: isReadOnly,
        inputFormatters: [
          ...inputFormatters,
        ],
      ),
      onBlurBackground,
    );
  }
}
