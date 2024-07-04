import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";
import "package:flutter_product_page/src/widgets/product_item_popup.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// Configuration for the product page.
class ProductPageConfiguration {
  /// Constructor for the product page configuration.
  ProductPageConfiguration({
    required this.shoppingService,
    required this.shops,
    required this.getProducts,
    required this.onAddToCart,
    required this.onNavigateToShoppingCart,
    required this.getProductsInShoppingCart,
    this.shoppingCartButtonBuilder = _defaultShoppingCartButtonBuilder,
    this.initialShopId,
    this.productBuilder,
    this.onShopSelectionChange,
    this.translations = const ProductPageTranslations(),
    this.shopSelectorStyle = ShopSelectorStyle.spacedWrap,
    this.pagePadding = const EdgeInsets.all(4),
    this.appBar = _defaultAppBar,
    this.bottomNavigationBar,
    this.onProductDetail = _onProductDetail,
    this.discountDescription = _defaultDiscountDescription,
    this.noContentBuilder = _defaultNoContentBuilder,
    this.errorBuilder = _defaultErrorBuilder,
  });

  /// The shopping service that is used
  final ShoppingService shoppingService;

  /// The shop that is initially selected.
  final String? initialShopId;

  /// A list of all the shops that the user must be able to navigate from.
  final Future<List<Shop>> Function() shops;

  /// A function that returns all the products that belong to a certain shop.
  /// The function must return a [List<Product>].
  final Future<List<Product>> Function(Shop shop) getProducts;

  /// The localizations for the product page.
  final ProductPageTranslations translations;

  /// Builder for the product item. These items will be displayed in the list
  /// for each product in their seperated category. This builder should only
  /// build the widget for one specific product. This builder has a default
  /// in-case the developer does not override it.
  Widget Function(BuildContext context, Product product)? productBuilder;

  /// The builder for the product popup. This builder should return a widget
  Function(
    BuildContext context,
    Product product,
    String closeText,
  ) onProductDetail;

  /// The builder for the shopping cart. This builder should return a widget
  /// that navigates to the shopping cart overview page.
  Widget Function(
    BuildContext context,
    ProductPageConfiguration configuration,
  ) shoppingCartButtonBuilder;

  /// The function that returns the discount description for a product.
  String Function(
    Product product,
  ) discountDescription;

  /// This function must be implemented by the developer and should handle the
  /// adding of a product to the cart.
  Function(Product product) onAddToCart;

  /// This function gets executed when the user changes the shop selection.
  /// This function always fires upon first load with the initial shop as well.
  final Function(Shop shop)? onShopSelectionChange;

  /// This function must be implemented by the developer and should handle the
  /// navigation to the shopping cart overview page.
  final int Function() getProductsInShoppingCart;

  /// This function must be implemented by the developer and should handle the
  /// navigation to the shopping cart overview page.
  final Function() onNavigateToShoppingCart;

  /// The style of the shop selector.
  final ShopSelectorStyle shopSelectorStyle;

  /// The padding for the page.
  final EdgeInsets pagePadding;

  /// Optional app bar that you can pass to the product page screen.
  final Widget? bottomNavigationBar;

  /// Optional app bar that you can pass to the order detail screen.
  final AppBar Function(BuildContext context)? appBar;

  /// Builder for the no content widget. This builder is used when there is no
  /// content to display.
  final Widget Function(
    BuildContext context,
  )? noContentBuilder;

  /// Builder for the error widget. This builder is used when there is an error
  /// to display.
  Widget Function(
    BuildContext context,
    Object? error,
    StackTrace? stackTrace,
  ) errorBuilder;
}

AppBar _defaultAppBar(
  BuildContext context,
) {
  var theme = Theme.of(context);

  return AppBar(
    leading: IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt)),
    ],
    title: Text(
      "Product page",
      style: theme.textTheme.headlineLarge,
    ),
  );
}

Widget _defaultShoppingCartButtonBuilder(
  BuildContext context,
  ProductPageConfiguration configuration,
) {
  var theme = Theme.of(context);

  return ListenableBuilder(
    listenable: configuration.shoppingService.shoppingCartService,
    builder: (context, widget) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: configuration
                  .shoppingService.shoppingCartService.products.isNotEmpty
              ? configuration.onNavigateToShoppingCart
              : null,
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
              configuration.translations.navigateToShoppingCart,
              style: theme.textTheme.displayLarge,
            ),
          ),
        ),
      ),
    ),
  );
}

Future<void> _onProductDetail(
  BuildContext context,
  Product product,
  String closeText,
) async {
  var theme = Theme.of(context);

  await showModalBottomSheet(
    context: context,
    backgroundColor: theme.colorScheme.surface,
    builder: (context) => ProductItemPopup(
      product: product,
      closeText: closeText,
    ),
  );
}

String _defaultDiscountDescription(
  Product product,
) =>
    "${product.name}, now for ${product.discountPrice} each";

Widget _defaultNoContentBuilder(
  BuildContext context,
) {
  var theme = Theme.of(context);
  return Center(
    child: Text(
      "No content",
      style: theme.textTheme.titleLarge,
    ),
  );
}

Widget _defaultErrorBuilder(
  BuildContext context,
  Object? error,
  StackTrace? stackTrace,
) {
  var theme = Theme.of(context);
  return Center(
    child: Text(
      "Error: $error",
      style: theme.textTheme.titleLarge,
    ),
  );
}
