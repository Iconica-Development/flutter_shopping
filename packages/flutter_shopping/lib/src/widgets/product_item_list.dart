import "package:flutter/material.dart";
import "package:flutter_shopping/flutter_shopping.dart";

/// ProductItemList
class ProductItemList extends StatelessWidget {
  /// Constructor for the product item list.
  const ProductItemList({
    required this.products,
    required this.onAddToCart,
    required this.translations,
    required this.options,
    super.key,
  });

  /// The items.
  final Map<String, List<Product>> products;

  /// The on add to cart function.
  final Function(Product) onAddToCart;

  /// The translations.
  final ShoppingTranslations translations;

  /// The options.
  final FlutterShoppingOptions options;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: products.entries
          .map(
            (entry) => Column(
              children: [
                Row(
                  children: [
                    Text(
                      entry.key,
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                Column(
                  children: entry.value
                      .map(
                        (product) =>
                            options.productItemBuilder?.call(
                              context,
                              product,
                            ) ??
                            ProductItem(
                              options: options,
                              product: product,
                              translations: translations,
                              onAddToCart: (product) async {
                                await onAddToCart(product);
                              },
                            ),
                      )
                      .toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
