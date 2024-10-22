import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_shopping/flutter_shopping.dart";

/// Weekly offer.
class WeeklyOffer extends StatelessWidget {
  /// Constructor for the weekly offer.
  const WeeklyOffer({
    required this.product,
    required this.translations,
    super.key,
  });

  /// The product.
  final Product? product;

  /// The translations.
  final ShoppingTranslations translations;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Container(
        width: double.infinity,
        height: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              product!.imageUrl,
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  translations.weeklyOffer,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
            ),
            const Spacer(),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "${product!.name}, now for ${product!.discountPrice} each",
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
