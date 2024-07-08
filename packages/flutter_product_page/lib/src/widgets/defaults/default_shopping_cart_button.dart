import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";

/// Default shopping cart button for the product page.
class DefaultShoppingCartButton extends StatelessWidget {
  /// Constructor for the default shopping cart button for the product page.
  const DefaultShoppingCartButton({
    required this.configuration,
    super.key,
  });

  /// Configuration for the product page.
  final ProductPageConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return ListenableBuilder(
      listenable: configuration.shoppingService.shoppingCartService,
      builder: (context, widget) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: configuration
                    .shoppingService.shoppingCartService.products.isNotEmpty
                ? configuration.onNavigateToShoppingCart
                : null,
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
                configuration.translations.navigateToShoppingCart,
                style: theme.textTheme.displayLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
