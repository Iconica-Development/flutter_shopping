import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";
import "package:flutter_product_page/src/services/selected_shop_service.dart";
import "package:flutter_product_page/src/ui/widgets/horizontal_list_items.dart";
import "package:flutter_product_page/src/ui/widgets/spaced_wrap.dart";

/// Shop selector widget that displays a list to navigate between shops.
class ShopSelector extends StatelessWidget {
  /// Constructor for the shop selector.
  const ShopSelector({
    required this.configuration,
    required this.selectedShopService,
    required this.shops,
    required this.onTap,
    this.paddingBetweenButtons = 4,
    this.paddingOnButtons = 8,
    super.key,
  });

  /// Configuration for the product page.
  final ProductPageConfiguration configuration;

  /// Service for the selected shop.
  final SelectedShopService selectedShopService;

  /// List of shops.
  final List<ProductPageShop> shops;

  /// Callback when a shop is tapped.
  final Function(ProductPageShop shop) onTap;

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
        selectedItem: selectedShopService.selectedShop!.id,
        onTap: onTap,
        width: MediaQuery.of(context).size.width - (16 * 2),
        paddingBetweenButtons: paddingBetweenButtons,
        paddingOnButtons: paddingOnButtons,
      );
    }

    return HorizontalListItems(
      shops: shops,
      selectedItem: selectedShopService.selectedShop!.id,
      onTap: onTap,
      paddingBetweenButtons: paddingBetweenButtons,
      paddingOnButtons: paddingOnButtons,
    );
  }
}
