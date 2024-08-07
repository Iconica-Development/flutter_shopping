import "package:flutter/material.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// Horizontal list of items.
class HorizontalListItems extends StatelessWidget {
  /// Constructor for the horizontal list of items.
  const HorizontalListItems({
    required this.shops,
    required this.selectedItem,
    required this.onTap,
    this.paddingBetweenButtons = 2.0,
    this.paddingOnButtons = 6,
    super.key,
  });

  /// List of items.
  final List<Shop> shops;

  /// Selected item.
  final String selectedItem;

  /// Padding between the buttons.
  final double paddingBetweenButtons;

  /// Padding on the buttons.
  final double paddingOnButtons;

  /// Callback when an item is tapped.
  final Function(Shop shop) onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        top: 4,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: shops
              .map(
                (shop) => Padding(
                  padding: EdgeInsets.only(right: paddingBetweenButtons),
                  child: InkWell(
                    onTap: () => onTap(shop),
                    child: Container(
                      decoration: BoxDecoration(
                        color: shop.id == selectedItem
                            ? theme.colorScheme.primary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: theme.colorScheme.primary,
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.all(paddingOnButtons),
                      child: Text(
                        shop.name,
                        style: shop.id == selectedItem
                            ? theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )
                            : theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
