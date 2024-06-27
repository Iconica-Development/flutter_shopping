import "package:flutter/material.dart";
import "package:flutter_shopping/flutter_shopping.dart";
import "package:flutter_shopping_cart/src/widgets/product_item_popup.dart";

Widget _defaultNoContentBuilder(BuildContext context) =>
    const SizedBox.shrink();

/// Shopping cart configuration
///
/// This class is used to configure the shopping cart.
class ShoppingCartConfig<T extends Product> {
  /// Creates a shopping cart configuration.
  ShoppingCartConfig({
    required this.productService,
    this.productItemBuilder = _defaultProductItemBuilder,
    this.onConfirmOrder,
    this.confirmOrderButtonBuilder,
    this.confirmOrderButtonHeight = 100,
    this.sumBottomSheetBuilder,
    this.sumBottomSheetHeight = 100,
    this.titleBuilder,
    this.localizations = const ShoppingCartLocalizations(),
    this.padding = const EdgeInsets.symmetric(horizontal: 32),
    this.bottomPadding = const EdgeInsets.fromLTRB(44, 0, 44, 32),
    this.appBar,
    Widget Function(BuildContext context) noContentBuilder =
        _defaultNoContentBuilder,
  })  : assert(
          confirmOrderButtonBuilder != null || onConfirmOrder != null,
          """
If you override the confirm order button builder,
you cannot use the onConfirmOrder callback.""",
        ),
        assert(
          confirmOrderButtonBuilder == null || onConfirmOrder == null,
          """
If you do not override the confirm order button builder,
you must use the onConfirmOrder callback.""",
        ),
        _noContentBuilder = noContentBuilder;

  /// Product Service. The service contains all the products that
  /// a shopping cart can contain. Each product must extend the [Product] class.
  /// The service is used to add, remove, and update products.
  ///
  /// The service can be seperate for each shopping cart in-case you want to
  /// support seperate shopping carts for shop.
  ProductService<T> productService = ProductService<T>(<T>[]);

  /// Product item builder. This builder is used to build the product item
  /// that will be displayed in the shopping cart.
  final Widget Function(
    BuildContext context,
    Locale locale,
    Product product,
    ProductService<Product> productService,
    ShoppingCartConfig configuration,
  ) productItemBuilder;

  final Widget Function(BuildContext context) _noContentBuilder;

  /// No content builder. This builder is used to build the no content widget
  /// that will be displayed in the shopping cart when there are no products.
  Widget Function(BuildContext context) get noContentBuilder =>
      _noContentBuilder;

  /// Confirm order button builder. This builder is used to build the confirm
  /// order button that will be displayed in the shopping cart.
  /// If you override this builder, you cannot use the [onConfirmOrder] callback
  final Widget Function(BuildContext context)? confirmOrderButtonBuilder;

  /// Confirm order button height. The height of the confirm order button.
  /// This height is used to calculate the bottom padding of the shopping cart.
  /// If you override the confirm order button builder, you must provide a
  /// height.
  final double confirmOrderButtonHeight;

  /// Confirm order callback. This callback is called when the confirm order
  /// button is pressed. The callback will not be called if you override the
  /// confirm order button builder.
  final Function(List<T> products)? onConfirmOrder;

  /// Sum bottom sheet builder. This builder is used to build the sum bottom
  /// sheet that will be displayed in the shopping cart. The sum bottom sheet
  /// can be used to display the total sum of the products in the shopping cart.
  final Widget Function(BuildContext context)? sumBottomSheetBuilder;

  /// Sum bottom sheet height. The height of the sum bottom sheet.
  /// This height is used to calculate the bottom padding of the shopping cart.
  /// If you override the sum bottom sheet builder, you must provide a height.
  final double sumBottomSheetHeight;

  /// Padding around the shopping cart. The padding is used to create space
  /// around the shopping cart.
  final EdgeInsets padding;

  /// Bottom padding of the shopping cart. The bottom padding is used to create
  /// a padding around the bottom sheet. This padding is ignored when the
  /// [sumBottomSheetBuilder] is overridden.
  final EdgeInsets bottomPadding;

  /// Title builder. This builder is used to build the title of the shopping
  /// cart. The title is displayed at the top of the shopping cart. If you
  /// use the title builder, the [title] will be ignored.
  final Widget Function(BuildContext context)? titleBuilder;

  /// Shopping cart localizations. The localizations are used to localize the
  /// shopping cart.
  final ShoppingCartLocalizations localizations;

  /// App bar for the shopping cart screen.
  final PreferredSizeWidget? appBar;
}

Widget _defaultProductItemBuilder(
  BuildContext context,
  Locale locale,
  Product product,
  ProductService<Product> service,
  ShoppingCartConfig configuration,
) {
  var theme = Theme.of(context);
  return Padding(
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
            onPressed: () async {
              await showModalBottomSheet(
                context: context,
                backgroundColor: theme.colorScheme.surface,
                builder: (context) => ProductItemPopup(product: product, configuration: configuration)
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
          Text(
            product.price.toStringAsFixed(2),
            style: theme.textTheme.labelSmall,
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
                onPressed: () => service.removeOneProduct(product),
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
                onPressed: () => service.addProduct(product),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
