import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";

/// A popup that displays the product item.
class ProductItemPopup extends StatelessWidget {
  /// Constructor for the product item popup.
  const ProductItemPopup({
    required this.product,
    required this.configuration,
    super.key,
  });

  /// The product to display.
  final ProductPageProduct product;

  /// Configuration for the product page.
  final ProductPageConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var productDescription = Padding(
      padding: const EdgeInsets.fromLTRB(44, 32, 44, 20),
      child: Text(
        product.name,
        textAlign: TextAlign.center,
      ),
    );

    var closeButton = Padding(
      padding: const EdgeInsets.fromLTRB(80, 0, 80, 32),
      child: SizedBox(
        width: 254,
        child: ElevatedButton(
          style: theme.elevatedButtonTheme.style?.copyWith(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Text(
              configuration.localizations.close,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            productDescription,
            closeButton,
          ],
        ),
      ),
    );
  }
}
