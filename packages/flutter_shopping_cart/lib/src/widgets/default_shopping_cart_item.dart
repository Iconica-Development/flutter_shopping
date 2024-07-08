import "package:flutter/material.dart";
import "package:flutter_shopping_cart/flutter_shopping_cart.dart";
import "package:flutter_shopping_cart/src/widgets/product_item_popup.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// Default shopping cart item.
class DefaultShoppingCartItem extends StatelessWidget {
  /// Constructor for the default shopping cart item.
  const DefaultShoppingCartItem({
    required this.product,
    required this.configuration,
    super.key,
  });

  /// Product to display.
  final Product product;

  /// Shopping cart configuration.
  final ShoppingCartConfig configuration;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListenableBuilder(
      listenable: configuration.service,
      builder: (context, _) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          contentPadding: const EdgeInsets.only(top: 3, left: 4, bottom: 3),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: theme.textTheme.titleMedium,
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    backgroundColor: theme.colorScheme.surface,
                    builder: (context) => ProductItemPopup(
                      product: product,
                      configuration: configuration,
                    ),
                  );
                },
                icon: Icon(
                  Icons.info_outline,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              product.imageUrl,
            ),
          ),
          trailing: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (product.hasDiscount && product.discountPrice != null) ...[
                    Text(
                      product.discountPrice!.toStringAsFixed(2),
                      style: theme.textTheme.labelSmall,
                    ),
                  ] else ...[
                    Text(
                      product.price.toStringAsFixed(2),
                      style: theme.textTheme.labelSmall,
                    ),
                  ],
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.black,
                    ),
                    onPressed: () =>
                        configuration.service.removeOneProduct(product),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      height: 30,
                      width: 30,
                      child: Text(
                        "${product.quantity}",
                        style: theme.textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  IconButton(
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      configuration.service.addProduct(product);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
