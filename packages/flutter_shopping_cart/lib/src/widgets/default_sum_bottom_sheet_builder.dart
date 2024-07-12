import "package:flutter/material.dart";
import "package:flutter_shopping_cart/flutter_shopping_cart.dart";

/// Default sum bottom sheet builder.
class DefaultSumBottomSheetBuilder extends StatelessWidget {
  /// Constructor for the default sum bottom sheet builder.
  const DefaultSumBottomSheetBuilder({
    required this.configuration,
    super.key,
  });

  /// Configuration for the shopping cart.
  final ShoppingCartConfig configuration;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var totalPrice = configuration.service.products.fold<double>(
      0,
      (previousValue, element) =>
          previousValue +
          (element.discountPrice ?? element.price) * element.quantity,
    );

    return Padding(
      padding: configuration.bottomPadding,
      child: Row(
        children: [
          Text(
            configuration.translations.sum,
            style: theme.textTheme.titleMedium,
          ),
          const Spacer(),
          Text(
            "€ ${totalPrice.toStringAsFixed(2)}",
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
