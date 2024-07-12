import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";
import "package:skeletonizer/skeletonizer.dart";

/// Product item widget.
class DefaultProductItem extends StatelessWidget {
  /// Constructor for the product item widget.
  const DefaultProductItem({
    required this.product,
    required this.onProductDetail,
    required this.onAddToCart,
    required this.translations,
    super.key,
  });

  /// Product to display.
  final Product product;

  /// Function to call when the product detail is requested.
  final Function(
    BuildContext context,
    Product selectedProduct,
    String closeText,
  ) onProductDetail;

  /// Function to call when the product is added to the cart.
  final Function(Product selectedProduct) onAddToCart;

  /// Localizations for the product page.
  final ProductPageTranslations translations;

  /// Size of the product image.
  static const double imageSize = 44;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var loadingImageSkeleton = const Skeletonizer.zone(
      child: SizedBox(width: imageSize, height: imageSize, child: Bone.icon()),
    );

    var productIcon = ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: CachedNetworkImage(
        imageUrl: product.imageUrl,
        width: imageSize,
        height: imageSize,
        fit: BoxFit.cover,
        placeholder: (context, url) => loadingImageSkeleton,
        errorWidget: (context, url, error) => Tooltip(
          message: translations.failedToLoadImageExplenation,
          child: Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            child: const Icon(
              Icons.error_outline_sharp,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );

    var productName = Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 150),
        child: Text(
          product.name,
          style: theme.textTheme.titleMedium,
        ),
      ),
    );

    var productInformationIcon = Padding(
      padding: const EdgeInsets.only(left: 4),
      child: IconButton(
        onPressed: () => onProductDetail(
          context,
          product,
          translations.close,
        ),
        icon: Icon(
          Icons.info_outline,
          color: theme.colorScheme.primary,
        ),
      ),
    );

    var productInteraction = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _PriceLabel(
          product: product,
        ),
        _AddToCardButton(
          product: product,
          onAddToCart: onAddToCart,
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      child: Row(
        children: [
          productIcon,
          productName,
          productInformationIcon,
          const Spacer(),
          productInteraction,
        ],
      ),
    );
  }
}

class _PriceLabel extends StatelessWidget {
  const _PriceLabel({
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Row(
      children: [
        if (product.hasDiscount) ...[
          Text(
            product.price.toStringAsFixed(2),
            style: theme.textTheme.bodySmall?.copyWith(
              decoration: TextDecoration.lineThrough,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(width: 4),
        ],
        Text(
          product.hasDiscount
              ? product.discountPrice!.toStringAsFixed(2)
              : product.price.toStringAsFixed(2),
          style: theme.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _AddToCardButton extends StatelessWidget {
  const _AddToCardButton({
    required this.product,
    required this.onAddToCart,
  });

  final Product product;
  final Function(Product product) onAddToCart;

  static const double boxSize = 29;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(4),
      ),
      width: boxSize,
      height: boxSize,
      child: Center(
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.add,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => onAddToCart(product),
        ),
      ),
    );
  }
}
