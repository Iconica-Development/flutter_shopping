import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";
import "package:flutter_product_page/src/widgets/horizontal_list_items.dart";
import "package:flutter_product_page/src/widgets/spaced_wrap.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// Shop selector widget that displays a list to navigate between shops.
class ShopSelector extends StatefulWidget {
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
  State<ShopSelector> createState() => _ShopSelectorState();
}

class _ShopSelectorState extends State<ShopSelector> {
  @override
  void initState() {
    widget.configuration.shoppingService.shopService.addListener(_listen);
    super.initState();
  }

  @override
  void dispose() {
    widget.configuration.shoppingService.shopService.removeListener(_listen);
    super.dispose();
  }

  void _listen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shops.length == 1) {
      return const SizedBox.shrink();
    }

    if (widget.configuration.shopSelectorStyle ==
        ShopSelectorStyle.spacedWrap) {
      return SpacedWrap(
        shops: widget.shops,
        selectedItem:
            widget.configuration.shoppingService.shopService.selectedShop!.id,
        onTap: widget.onTap,
        width: MediaQuery.of(context).size.width - (16 * 2),
        paddingBetweenButtons: widget.paddingBetweenButtons,
        paddingOnButtons: widget.paddingOnButtons,
      );
    }

    return HorizontalListItems(
      shops: widget.shops,
      selectedItem:
          widget.configuration.shoppingService.shopService.selectedShop!.id,
      onTap: widget.onTap,
      paddingBetweenButtons: widget.paddingBetweenButtons,
      paddingOnButtons: widget.paddingOnButtons,
    );
  }
}
