import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// A widget that displays a weekly discount.
class WeeklyDiscount extends StatelessWidget {
  /// Creates a weekly discount.
  const WeeklyDiscount({
    required this.configuration,
    required this.product,
    super.key,
  });

  /// Configuration for the product page.
  final ProductPageConfiguration configuration;

  /// The product for which the discount is displayed.
  final Product product;

  /// The top padding of the widget.
  static const double topPadding = 20;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var bottomText = Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        configuration.discountDescription(product),
        style: theme.textTheme.bodyMedium,
        textAlign: TextAlign.left,
      ),
    );

    var loadingImage = const Padding(
      padding: EdgeInsets.all(32.0),
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );

    var errorImage = Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Colors.red,
            ),
            Text(configuration.translations.failedToLoadImageExplenation),
          ],
        ),
      ),
    );

    var image = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: CachedNetworkImage(
          imageUrl: product.imageUrl,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => loadingImage,
          errorWidget: (context, url, error) => errorImage,
        ),
      ),
    );

    var topText = DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: Text(
            configuration.translations.discountTitle,
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );

    var boxDecoration = BoxDecoration(
      border: Border.all(
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(4.0),
    );

    return Padding(
      padding: const EdgeInsets.only(top: topPadding),
      child: DecoratedBox(
        decoration: boxDecoration,
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topText,
              image,
              bottomText,
            ],
          ),
        ),
      ),
    );
  }
}
