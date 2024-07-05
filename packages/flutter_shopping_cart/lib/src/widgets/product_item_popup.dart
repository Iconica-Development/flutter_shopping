import "package:flutter/material.dart";
import "package:flutter_shopping_cart/flutter_shopping_cart.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// A popup that displays the product item.
class ProductItemPopup extends StatelessWidget {
  /// Constructor for the product item popup.
  const ProductItemPopup({
    required this.product,
    required this.configuration,
    super.key,
  });

  /// The product to display.
  final Product product;

  /// Configuration for the product page.
  final ShoppingCartConfig configuration;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                product.description,
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: theme.filledButtonTheme.style?.copyWith(
                      backgroundColor: WidgetStateProperty.all(
                        theme.colorScheme.primary,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        configuration.translations!.close,
                        style: theme.textTheme.displayLarge,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
