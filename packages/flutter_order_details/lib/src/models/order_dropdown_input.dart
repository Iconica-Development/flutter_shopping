import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";

/// Order Detail input for a dropdown input.
class OrderDropdownInput<T> extends OrderDetailInput<T> {
  /// Constructor for the order dropdown input.
  OrderDropdownInput({
    required super.title,
    required super.outputKey,
    required this.items,
    super.titleStyle,
    super.titleAlignment,
    super.titlePadding,
    super.subtitle,
    super.errorIsRequired,
    super.isRequired = true,
    super.isReadOnly,
    super.initialValue,
    this.blurOnInteraction = true,
  });

  /// Items to show within the dropdown menu.
  final List<T> items;

  /// Whether or not the screen should blur when interacting.
  final bool blurOnInteraction;

  @override
  Widget build(
    BuildContext context,
    T? buildInitialValue,
    Function({bool needsBlur}) onBlurBackground,
  ) {
    var theme = Theme.of(context);

    void onItemChanged(T? value) {
      currentValue = value;
      onValueChanged?.call(value as T);
      onBlurBackground(needsBlur: false);
    }

    void onPopupOpen() {
      if (blurOnInteraction)
        onBlurBackground(
          needsBlur: true,
        );
    }

    var inputDecoration = InputDecoration(
      labelText: titleStyle == OrderDetailTitleStyle.label ? title : null,
      hintText: hint,
      filled: true,
      fillColor: theme.inputDecorationTheme.fillColor,
      border: InputBorder.none,
    );

    currentValue =
        currentValue ?? initialValue ?? buildInitialValue ?? items[0];

    return buildOutline(
      context,
      DropdownButtonFormField<T>(
        value: currentValue ?? initialValue ?? buildInitialValue ?? items[0],
        selectedItemBuilder: (context) => items
            .map(
              (item) => Text(
                item.toString(),
                style: theme.textTheme.labelMedium,
              ),
            )
            .toList(),
        items: items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: _DropdownButtonBuilder<T>(
                  item: item,
                  currentValue: currentValue,
                ),
              ),
            )
            .toList(),
        onChanged: onItemChanged,
        onTap: onPopupOpen,
        style: theme.textTheme.labelMedium,
        decoration: inputDecoration,
        borderRadius: BorderRadius.circular(10),
        icon: const Icon(Icons.keyboard_arrow_down_sharp),
        validator: super.validate,
      ),
      onBlurBackground,
    );
  }
}

class _DropdownButtonBuilder<T> extends StatelessWidget {
  const _DropdownButtonBuilder({
    required this.item,
    this.currentValue,
    super.key,
  });

  final T item;
  final T? currentValue;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var textBuilder = Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          item.toString(),
          style: theme.textTheme.labelMedium?.copyWith(
            color: item == currentValue ? theme.colorScheme.onPrimary : null,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );

    var selectedIcon = Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(
          Icons.check,
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: item == currentValue ? theme.colorScheme.primary : null,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: theme.colorScheme.primary,
        ),
      ),
      child: Stack(
        children: [
          textBuilder,
          if (currentValue == item) ...[
            selectedIcon,
          ],
        ],
      ),
    );
  }
}
