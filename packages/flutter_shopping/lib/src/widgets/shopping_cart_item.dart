import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_shopping/flutter_shopping.dart";

/// The shopping cart item.
class ShoppingCartItem extends StatelessWidget {
  /// Constructor for the shopping cart item.
  const ShoppingCartItem({
    required this.product,
    required this.onAddToCart,
    required this.onRemoveFromCart,
    required this.translations,
    required this.options,
    super.key,
  });

  /// The product.
  final Product product;

  /// The on add to cart function.
  final Function(Product product) onAddToCart;

  /// The on remove from cart function.
  final Function(Product product) onRemoveFromCart;

  /// The translations.
  final ShoppingTranslations translations;

  /// The options.
  final FlutterShoppingOptions options;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      product.imageUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name,
                    style: theme.textTheme.titleMedium,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {
                      options.onInfoPressed?.call(product) ??
                          showBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            builder: (context) => InfoBottomsheet(
                              productInfo: product.description,
                              translations: translations,
                            ),
                          );
                    },
                    icon: Icon(
                      Icons.info_outline_rounded,
                      color: theme.primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Text(
                product.isDiscounted
                    ? product.discountPrice.toStringAsFixed(2)
                    : product.price.toStringAsFixed(2),
                style: theme.textTheme.bodySmall?.copyWith(fontSize: 14),
              ),
              Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () async {
                      await onRemoveFromCart(product);
                    },
                    icon: const Icon(Icons.remove_rounded),
                  ),
                  InkWell(
                    onTap: () async {
                      await onAddToCart(product);
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          product.selectedAmount.toString(),
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () async {
                      await onAddToCart(product);
                    },
                    icon: const Icon(Icons.add_rounded),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
