import "package:flutter/material.dart";
import "package:flutter_shopping/flutter_shopping.dart";

/// The shopping cart screen.
class ShoppingCartScreen extends StatelessWidget {
  /// Constructor for the shopping cart screen.
  const ShoppingCartScreen({
    required this.shoppingService,
    required this.translations,
    required this.onOrder,
    required this.options,
    super.key,
  });

  /// The shopping service.
  final ShoppingService shoppingService;

  /// The translations.
  final ShoppingTranslations translations;

  /// the on order callback.
  final Function() onOrder;

  /// The options.
  final FlutterShoppingOptions options;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.shoppingCartTitle),
      ),
      body: StreamBuilder(
        stream: shoppingService.getShoppingCart(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var cart = snapshot.data!;
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translations.shoppingCartProducts,
                          style: theme.textTheme.titleLarge,
                        ),
                        Column(
                          children: cart.products
                              .map(
                                (product) =>
                                    options.shoppingCartItemBuilder?.call(
                                      context,
                                      product,
                                      () async {
                                        await shoppingService
                                            .addProductToCart(product);
                                      },
                                      () async {
                                        await shoppingService
                                            .removeProductFromCart(product);
                                      },
                                    ) ??
                                    ShoppingCartItem(
                                      options: options,
                                      translations: translations,
                                      product: product,
                                      onAddToCart: (product) async {
                                        await shoppingService
                                            .addProductToCart(product);
                                      },
                                      onRemoveFromCart: (product) async {
                                        await shoppingService
                                            .removeProductFromCart(product);
                                      },
                                    ),
                              )
                              .toList(),
                        ),
                        const SizedBox(
                          height: 200,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ColoredBox(
                    color: theme.scaffoldBackgroundColor,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 32,
                        left: 64,
                        right: 64,
                        top: 16,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                translations.shoppingCartTotal,
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                "${translations.shoppingCartCurrency}"
                                // ignore: lines_longer_than_80_chars
                                " ${cart.totalAmountWithDiscount.toStringAsFixed(2)}",
                                style: theme.textTheme.titleMedium,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          options.primaryButtonBuilder?.call(
                                context,
                                cart.products.isNotEmpty,
                                translations.orderButton,
                                onOrder,
                              ) ??
                              PrimaryButton(
                                enabled: cart.products.isNotEmpty,
                                text: translations.orderButton,
                                onPressed: onOrder,
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
