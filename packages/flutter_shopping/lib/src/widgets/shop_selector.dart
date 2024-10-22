import "package:flutter/material.dart";
import "package:flutter_shopping/flutter_shopping.dart";

/// Shop selector.
class ShopSelector extends StatelessWidget {
  /// Constructor for the shop selector.
  const ShopSelector({
    required this.shoppingService,
    required this.onSelected,
    required this.options,
    required this.shops,
    super.key,
  });

  /// The shopping service.
  final ShoppingService shoppingService;

  /// The on selected function.
  final Function(Shop) onSelected;

  /// The options.
  final FlutterShoppingOptions options;

  ///
  final List<Shop> shops;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Row(
              children: shops
                  .map(
                    (shop) => Row(
                      children: [
                        const SizedBox(width: 4),
                        options.shopSelectorItemBuilder
                                ?.call(context, shop, onSelected) ??
                            ShopSelectorItem(
                              shoppingService: shoppingService,
                              onSelected: onSelected,
                              shop: shop,
                            ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
}
