import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_order_details/flutter_order_details.dart";

/// Order input for addresses with with predefined text fields and validation.
class OrderAddressInput extends OrderDetailInput<String> {
  /// Constructor of the order address input.
  OrderAddressInput({
    required super.title,
    required super.outputKey,
    required this.textController,
    super.titleStyle,
    super.titleAlignment,
    super.titlePadding,
    super.subtitle,
    super.errorIsRequired,
    super.hint = "0000XX",
    super.isRequired,
    super.isReadOnly,
    super.initialValue,
    this.streetNameTitle = "Street name",
    this.postalCodeTitle = "Postal code",
    this.cityTitle = "City",
    this.streetNameValidators,
    this.postalCodeValidators,
    this.cityValidators,
    this.inputFormatters,
    super.paddingBetweenFields = const EdgeInsets.symmetric(vertical: 4),
  });

  /// Title for the street name.
  final String streetNameTitle;

  /// Title for the postal code.
  final String postalCodeTitle;

  /// Title for the city.
  final String cityTitle;

  /// Text Control parent that contains the value of all the other three
  /// controllers.
  final TextEditingController textController;

  /// Text Controller for street names.
  final TextEditingController streetNameController = TextEditingController();

  /// Text Controller for postal codes.
  final TextEditingController postalCodeController = TextEditingController();

  /// Text Controller for the city name.
  final TextEditingController cityController = TextEditingController();

  /// Validators for the street name.
  final List<String? Function(String?)>? streetNameValidators;

  /// Validators for the postal code.
  final List<String? Function(String?)>? postalCodeValidators;

  /// Validators for the city.
  final List<String? Function(String?)>? cityValidators;

  /// Input formatters for the postal code.
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(
    BuildContext context,
    String? buildInitialValue,
    Function({bool needsBlur}) onBlurBackground,
  ) {
    void setUpControllers(String address) {
      var addressParts = address.split(", ");

      if (addressParts.isNotEmpty) {
        streetNameController.text = addressParts[0];
      }

      if (addressParts.length > 1) {
        postalCodeController.text = addressParts[1];
      }

      if (addressParts.length > 2) {
        cityController.text = addressParts[2];
      }
    }

    void inputChanged(String _) {
      var address = "${streetNameController.text}, "
          "${postalCodeController.text}, "
          "${cityController.text}";

      textController.text = address;

      currentValue = address;
      onValueChanged?.call(address);
    }

    textController.text = initialValue ?? buildInitialValue ?? "";
    currentValue = textController.text;

    setUpControllers(currentValue ?? "");

    return buildOutline(
      context,
      [
        OrderTextInput(
          title: streetNameTitle,
          outputKey: "internal_street_name",
          textController: streetNameController,
          titleStyle: OrderDetailTitleStyle.none,
          onValueChanged: inputChanged,
          hint: "De Dam 1",
          initialValue: streetNameController.text,
          validators: streetNameValidators ?? [],
        ),
        OrderTextInput(
          title: postalCodeTitle,
          outputKey: "internal_postal_code",
          textController: postalCodeController,
          titleStyle: OrderDetailTitleStyle.none,
          onValueChanged: inputChanged,
          validators: postalCodeValidators ??
              [
                (value) {
                  if (value?.length != 6) {
                    return "Postal code must be 6 characters";
                  }
                  return null;
                },
                (value) {
                  if (value != null &&
                      !RegExp(r"^\d{4}\s?[a-zA-Z]{2}$").hasMatch(value)) {
                    return "Postal code must be in the format 0000XX";
                  }
                  return null;
                }
              ],
          inputFormatters: inputFormatters ??
              [
                FilteringTextInputFormatter.allow(RegExp(r"^\d{0,4}[A-Z]*")),
                LengthLimitingTextInputFormatter(6),
              ],
          hint: hint,
          initialValue: postalCodeController.text,
        ),
        OrderTextInput(
          title: cityTitle,
          outputKey: "internal_city",
          textController: cityController,
          titleStyle: OrderDetailTitleStyle.none,
          onValueChanged: inputChanged,
          hint: "Amsterdam",
          initialValue: cityController.text,
          validators: cityValidators ?? [],
        ),
      ],
      onBlurBackground,
    );
  }
}
