import "package:flutter/material.dart";

/// Default error widget.
class DefaultError extends StatelessWidget {
  /// Constructor for the default error widget.
  const DefaultError({
    super.key,
    this.error,
  });

  /// Error that occurred.
  final Object? error;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: Text(
        "Error: $error",
        style: theme.textTheme.titleLarge,
      ),
    );
  }
}
