import "package:flutter/material.dart";
import "package:shopping_repository_interface/shopping_repository_interface.dart";

/// Shop selector item.
class ShopSelectorItem extends StatelessWidget {
  /// Constructor for the shop selector item.
  const ShopSelectorItem({
    required this.shop,
    required this.onSelected,
    required this.shoppingService,
    super.key,
  });

  /// The shop.
  final Shop shop;

  /// The on selected function.
  final Function(Shop) onSelected;

  /// The shopping service.
  final ShoppingService shoppingService;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var isSelected = shop.id == shoppingService.getSelectedShop()?.id;

    return InkWell(
      onTap: () => onSelected(shop),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: !isSelected ? Border.all(color: theme.primaryColor) : null,
          color: isSelected ? theme.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            shop.name,
            style: isSelected
                ? theme.textTheme.titleMedium?.copyWith(color: Colors.white)
                : theme.textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
