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
    this.shoppingCartButtonBuilder,
    this.initialShopId,
    this.productBuilder,
    this.onShopSelectionChange,
    this.translations = const ProductPageTranslations(),
    this.shopSelectorStyle = ShopSelectorStyle.row,
    this.pagePadding = const EdgeInsets.all(4),
    this.appBarBuilder,
    this.bottomNavigationBar,
    this.onProductDetail,
    this.discountDescription,
    this.noContentBuilder,
    this.errorBuilder,
    this.shopselectorBuilder,
    this.discountBuilder,
    this.categoryListBuilder,
    this.selectedCategoryBuilder,
  }) {
    onProductDetail ??= _onProductDetail;
    discountDescription ??= _defaultDiscountDescription;
  }

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
  final Widget Function(
    BuildContext context,
    Product product,
    ProductPageConfiguration configuration,
  )? productBuilder;

  /// The builder for the product popup. This builder should return a widget
  Function(
    BuildContext context,
    Product product,
    String closeText,
  )? onProductDetail;

  /// The builder for the shopping cart. This builder should return a widget
  /// that navigates to the shopping cart overview page.
  final Widget Function(
    BuildContext context,
    ProductPageConfiguration configuration,
  )? shoppingCartButtonBuilder;

  /// The function that returns the discount description for a product.
  String Function(
    Product product,
  )? discountDescription;

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
  final PreferredSizeWidget Function(BuildContext context)? appBarBuilder;

  /// Builder for the no content widget. This builder is used when there is no
  /// content to display.
  final Widget Function(
    BuildContext context,
  )? noContentBuilder;

  /// Builder for the error widget. This builder is used when there is an error
  /// to display.
  final Widget Function(
    BuildContext context,
    Object? error,
  )? errorBuilder;

  /// Builder for the shop selector. This builder is used to build the shop
  /// selector that will be displayed in the product page.
  final Widget Function(
    BuildContext context,
    ProductPageConfiguration configuration,
    List<Shop> shops,
    Function(Shop shop) onShopSelectionChange,
  )? shopselectorBuilder;

  /// Builder for the discount widget. This builder is used to build the
  /// discount widget that will be displayed in the product page.
  final Widget Function(
    BuildContext context,
    ProductPageConfiguration configuration,
    List<Product> discountedProducts,
  )? discountBuilder;

  /// Builder for the list of items that are displayed in the product page.
  final Widget Function(
    BuildContext context,
    ProductPageConfiguration configuration,
    List<Product> products,
  )? categoryListBuilder;

  /// Builder for the list of selected categories
  final Widget Function(ProductPageConfiguration configuration)?
      selectedCategoryBuilder;
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
