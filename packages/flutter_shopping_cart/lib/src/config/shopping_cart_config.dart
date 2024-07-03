import "package:flutter/material.dart";
import "package:flutter_shopping_cart/flutter_shopping_cart.dart";
import "package:flutter_shopping_cart/src/widgets/product_item_popup.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// Shopping cart configuration
///
/// This class is used to configure the shopping cart.
class ShoppingCartConfig {
  /// Creates a shopping cart configuration.
  ShoppingCartConfig({
    required this.service,
    required this.onConfirmOrder,
    this.productItemBuilder = _defaultProductItemBuilder,
    this.confirmOrderButtonBuilder = _defaultConfirmOrderButton,
    this.confirmOrderButtonHeight = 100,
    this.sumBottomSheetBuilder = _defaultSumBottomSheetBuilder,
    this.sumBottomSheetHeight = 100,
    this.titleBuilder,
    this.translations = const ShoppingCartTranslations(),
    this.pagePadding = const EdgeInsets.symmetric(horizontal: 32),
    this.bottomPadding = const EdgeInsets.fromLTRB(44, 0, 44, 32),
    this.appBar = _defaultAppBar,
  });

  /// Product service. The product service is used to manage the products in the
  /// shopping cart.
  final ShoppingCartService service;

  /// Product item builder. This builder is used to build the product item
  /// that will be displayed in the shopping cart.
  final Widget Function(
    BuildContext context,
    Product product,
    ShoppingCartConfig configuration,
  ) productItemBuilder;

  /// Confirm order button builder. This builder is used to build the confirm
  /// order button that will be displayed in the shopping cart.
  /// If you override this builder, you cannot use the [onConfirmOrder] callback
  final Widget Function(
    BuildContext context,
    ShoppingCartConfig configuration,
    Function(List<Product> products) onConfirmOrder,
  ) confirmOrderButtonBuilder;

  /// Confirm order button height. The height of the confirm order button.
  /// This height is used to calculate the bottom padding of the shopping cart.
  /// If you override the confirm order button builder, you must provide a
  /// height.
  final double confirmOrderButtonHeight;

  /// Confirm order callback. This callback is called when the confirm order
  /// button is pressed. The callback will not be called if you override the
  /// confirm order button builder.
  final Function(List<Product> products) onConfirmOrder;

  /// Sum bottom sheet builder. This builder is used to build the sum bottom
  /// sheet that will be displayed in the shopping cart. The sum bottom sheet
  /// can be used to display the total sum of the products in the shopping cart.
  final Widget Function(BuildContext context, ShoppingCartConfig configuration)
      sumBottomSheetBuilder;

  /// Sum bottom sheet height. The height of the sum bottom sheet.
  /// This height is used to calculate the bottom padding of the shopping cart.
  /// If you override the sum bottom sheet builder, you must provide a height.
  final double sumBottomSheetHeight;

  /// Padding around the shopping cart. The padding is used to create space
  /// around the shopping cart.
  final EdgeInsets pagePadding;

  /// Bottom padding of the shopping cart. The bottom padding is used to create
  /// a padding around the bottom sheet. This padding is ignored when the
  /// [sumBottomSheetBuilder] is overridden.
  final EdgeInsets bottomPadding;

  /// Title builder. This builder is used to
  /// build the title of the shopping cart.
  final Widget Function(
    BuildContext context,
    String title,
  )? titleBuilder;

  /// Shopping cart translations. The translations for the shopping cart.
  final ShoppingCartTranslations translations;

  /// Appbar for the shopping cart screen.
  final AppBar Function(BuildContext context) appBar;
}

Widget _defaultProductItemBuilder(
  BuildContext context,
  Product product,
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
                onPressed: () => configuration.service.addProduct(product),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _defaultSumBottomSheetBuilder(
  BuildContext context,
  ShoppingCartConfig configuration,
) {
  var theme = Theme.of(context);

  var totalPrice = configuration.service.products
      .map((product) => product.price * product.quantity)
      .fold(0.0, (a, b) => a + b);

  return Padding(
    padding: configuration.bottomPadding,
    child: Row(
      children: [
        Text(
          configuration.translations.sum,
          style: theme.textTheme.titleMedium,
        ),
        const Spacer(),
        Text(
          "€ ${totalPrice.toStringAsFixed(2)}",
          style: theme.textTheme.bodyMedium,
        ),
      ],
    ),
  );
}

Widget _defaultConfirmOrderButton(
  BuildContext context,
  ShoppingCartConfig configuration,
  Function(List<Product> products) onConfirmOrder,
) {
  var theme = Theme.of(context);

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 60),
    child: SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: () => onConfirmOrder(
          configuration.service.products,
        ),
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
            configuration.translations.placeOrder,
            style: theme.textTheme.displayLarge,
          ),
        ),
      ),
    ),
  );
}

AppBar _defaultAppBar(BuildContext context) {
  var theme = Theme.of(context);
  return AppBar(
    title: Text(
      "Shopping cart",
      style: theme.textTheme.headlineLarge,
    ),
  );
}
