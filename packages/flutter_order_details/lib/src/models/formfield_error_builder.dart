import "package:flutter/material.dart";

/// Error Builder for form fields.
class FormFieldErrorBuilder extends StatelessWidget {
  /// Constructor for the form field error builder.
  const FormFieldErrorBuilder({
    required this.errorMessage,
    super.key,
  });

  /// Error message to display.
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Text(
      errorMessage,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: theme.colorScheme.error,
      ),
    );
  }
}
