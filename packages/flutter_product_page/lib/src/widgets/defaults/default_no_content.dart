import "package:flutter/material.dart";

/// Default no content widget.
class DefaultNoContent extends StatelessWidget {
  /// Constructor for the default no content widget.
  const DefaultNoContent({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Center(
      child: Text(
        "No content",
        style: theme.textTheme.titleLarge,
      ),
    );
  }
}
