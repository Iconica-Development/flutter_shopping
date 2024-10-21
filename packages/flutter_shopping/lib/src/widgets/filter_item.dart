// ignore_for_file: avoid_positional_boolean_parameters

import "package:flutter/material.dart";
import "package:shopping_repository_interface/shopping_repository_interface.dart";

/// A filter item.
class FilterItem extends StatelessWidget {
  /// Constructor for the filter item.
  const FilterItem({
    required this.value,
    required this.onChanged,
    required this.category,
    super.key,
  });

  /// The category.
  final Category category;

  /// The value.
  final bool value;

  /// The on changed function.
  final Function(bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: value,
        onChanged: (value) {
          onChanged(value ?? false);
        },
        shape: const UnderlineInputBorder(),
        title: Text(
          category.name,
          style: theme.textTheme.bodyMedium,
        ),
      ),
    );
  }
}
