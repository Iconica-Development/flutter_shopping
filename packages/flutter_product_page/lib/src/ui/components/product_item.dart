import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";
import "package:skeletonizer/skeletonizer.dart";

/// Product item widget.
class ProductItem extends StatelessWidget {
  /// Constructor for the product item widget.
  const ProductItem({
    required this.product,
    required this.onProductDetail,
    required this.onAddToCart,
    required this.localizations,
    super.key,
  });

  /// Product to display.
  final ProductPageProduct product;

  /// Function to call when the product detail is requested.
  final Function(BuildContext context, ProductPageProduct selectedProduct)
      onProductDetail;

  /// Function to call when the product is added to the cart.
  final Function(ProductPageProduct selectedProduct) onAddToCart;

  /// Localizations for the product page.
  final ProductPageLocalization localizations;

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
          message: localizations.failedToLoadImageExplenation,
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
        onPressed: () => onProductDetail(context, product),
        icon: const Icon(Icons.info_outline),
      ),
    );

    var productInteraction = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _PriceLabel(
          price: product.price,
          discountPrice: (product.hasDiscount && product.discountPrice != null)
              ? product.discountPrice
              : null,
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
    required this.price,
    required this.discountPrice,
  });

  final double price;
  final double? discountPrice;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    if (discountPrice == null)
      return Text(
        price.toStringAsFixed(2),
        style: theme.textTheme.bodyMedium,
      );
    else
      return Row(
        children: [
          Text(
            price.toStringAsFixed(2),
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 10,
              color: theme.colorScheme.primary,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              discountPrice!.toStringAsFixed(2),
              style: theme.textTheme.bodyMedium,
            ),
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

  final ProductPageProduct product;
  final Function(ProductPageProduct product) onAddToCart;

  static const double boxSize = 29;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SizedBox(
      width: boxSize,
      height: boxSize,
      child: Center(
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.add,
            color: theme.primaryColor,
            size: 20,
          ),
          onPressed: () => onAddToCart(product),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              theme.colorScheme.secondary,
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
