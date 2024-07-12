import "package:flutter/material.dart";
import "package:flutter_shopping_cart/flutter_shopping_cart.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// Default confirm order button.
class DefaultConfirmOrderButton extends StatelessWidget {
  /// Constructor for the default confirm order button.
  const DefaultConfirmOrderButton({
    required this.configuration,
    required this.onConfirmOrder,
    super.key,
  });

  /// Configuration for the shopping cart.
  final ShoppingCartConfig configuration;

  /// Function to call when the order is confirmed.
  final Function(List<Product> products) onConfirmOrder;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: configuration.service.products.isEmpty
              ? null
              : () => onConfirmOrder(
                    configuration.service.products,
                  ),
          style: theme.filledButtonTheme.style?.copyWith(
            backgroundColor: WidgetStateProperty.all(
              theme.colorScheme.primary,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12,
            ),
            child: Text(
              configuration.translations.placeOrder,
              style: theme.textTheme.displayLarge,
            ),
          ),
        ),
      ),
    );
  }
}
