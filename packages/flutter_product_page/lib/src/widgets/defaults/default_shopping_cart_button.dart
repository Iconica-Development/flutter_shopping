import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";

/// Default shopping cart button for the product page.
class DefaultShoppingCartButton extends StatefulWidget {
  /// Constructor for the default shopping cart button for the product page.
  const DefaultShoppingCartButton({
    required this.configuration,
    super.key,
  });

  /// Configuration for the product page.
  final ProductPageConfiguration configuration;

  @override
  State<DefaultShoppingCartButton> createState() =>
      _DefaultShoppingCartButtonState();
}

class _DefaultShoppingCartButtonState extends State<DefaultShoppingCartButton> {
  @override
  void initState() {
    super.initState();
    widget.configuration.shoppingService.shoppingCartService
        .addListener(_listen);
  }

  @override
  void dispose() {
    widget.configuration.shoppingService.shoppingCartService
        .removeListener(_listen);
    super.dispose();
  }

  void _listen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: widget.configuration.shoppingService.shoppingCartService
                  .products.isNotEmpty
              ? widget.configuration.onNavigateToShoppingCart
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
              widget.configuration.translations.navigateToShoppingCart,
              style: theme.textTheme.displayLarge,
            ),
          ),
        ),
      ),
    );
  }
}
