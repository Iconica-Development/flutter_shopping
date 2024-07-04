import "package:flutter/material.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// SpacedWrap is a widget that wraps a list of items that are spaced out and
/// fill the available width.
class SpacedWrap extends StatelessWidget {
  /// Creates a [SpacedWrap].
  const SpacedWrap({
    required this.shops,
    required this.onTap,
    required this.width,
    this.paddingBetweenButtons = 2.0,
    this.paddingOnButtons = 4.0,
    this.selectedItem = "",
    super.key,
  });

  /// List of items.
  final List<Shop> shops;

  /// Selected item.
  final String selectedItem;

  /// Width of the widget.
  final double width;

  /// Padding between the buttons.
  final double paddingBetweenButtons;

  /// Padding on the buttons.
  final double paddingOnButtons;

  /// Callback when an item is tapped.
  final Function(Shop shop) onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 4,
      children: [
        for (var shop in shops) ...[
          Padding(
            padding: EdgeInsets.only(top: paddingBetweenButtons),
            child: InkWell(
              onTap: () => onTap(shop),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: shop.id == selectedItem
                      ? Theme.of(context).colorScheme.primary
                      : Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    shop.name,
                    style: shop.id == selectedItem
                        ? theme.textTheme.titleMedium
                            ?.copyWith(color: Colors.white)
                        : theme.textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
