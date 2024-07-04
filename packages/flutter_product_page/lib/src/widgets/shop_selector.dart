import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";
import "package:flutter_product_page/src/widgets/horizontal_list_items.dart";
import "package:flutter_product_page/src/widgets/spaced_wrap.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// Shop selector widget that displays a list to navigate between shops.
class ShopSelector extends StatelessWidget {
  /// Constructor for the shop selector.
  const ShopSelector({
    required this.configuration,
    required this.shops,
    required this.onTap,
    this.paddingBetweenButtons = 4,
    this.paddingOnButtons = 8,
    super.key,
  });

  /// Configuration for the product page.
  final ProductPageConfiguration configuration;

  /// Service for the selected shop.

  /// List of shops.
  final List<Shop> shops;

  /// Callback when a shop is tapped.
  final Function(Shop shop) onTap;

  /// Padding between the buttons.
  final double paddingBetweenButtons;

  /// Padding on the buttons.
  final double paddingOnButtons;

  @override
  Widget build(BuildContext context) {
    if (shops.length == 1) {
      return const SizedBox.shrink();
    }

    if (configuration.shopSelectorStyle == ShopSelectorStyle.spacedWrap) {
      return SpacedWrap(
        shops: shops,
        selectedItem:
            configuration.shoppingService.shopService.selectedShop!.id,
        onTap: onTap,
        width: MediaQuery.of(context).size.width - (16 * 2),
        paddingBetweenButtons: paddingBetweenButtons,
        paddingOnButtons: paddingOnButtons,
      );
    }

    return HorizontalListItems(
      shops: shops,
      selectedItem: configuration.shoppingService.shopService.selectedShop!.id,
      onTap: onTap,
      paddingBetweenButtons: paddingBetweenButtons,
      paddingOnButtons: paddingOnButtons,
    );
  }
}
