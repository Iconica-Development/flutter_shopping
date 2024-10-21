import "package:flutter/material.dart";

/// A primary button.
class PrimaryButton extends StatelessWidget {
  /// Constructor for the primary button.
  const PrimaryButton({
    required this.text,
    required this.onPressed,
    this.enabled = true,
    super.key,
  });

  /// The text.
  final String text;

  /// The on pressed function.
  final Function() onPressed;

  /// whether the button is enabled.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 254,
      ),
      child: FilledButton(
        onPressed: enabled ? onPressed : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            text,
            style: theme.textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}
