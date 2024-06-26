import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";
import "package:flutter_product_page/src/ui/widgets/product_item_popup.dart";

/// Configuration for the product page.
class ProductPageConfiguration {
  /// Constructor for the product page configuration.
  ProductPageConfiguration({
    required this.shops,
    //
    required this.getProducts,
    //
    required this.onAddToCart,
    required this.onNavigateToShoppingCart,
    this.navigateToShoppingCartBuilder,
    //
    this.initialShopId,
    //
    this.productBuilder,
    //
    this.onShopSelectionChange,
    this.getProductsInShoppingCart,
    //
    this.localizations = const ProductPageLocalization(),
    //
    this.shopSelectorStyle = ShopSelectorStyle.spacedWrap,
    this.categoryStylingConfiguration =
        const ProductPageCategoryStylingConfiguration(),
    //
    this.pagePadding = const EdgeInsets.all(4),
    //
    this.appBar,
    this.bottomNavigationBar,
    //
    Function(
      BuildContext context,
      ProductPageProduct product,
    )? onProductDetail,
    String Function(
      ProductPageProduct product,
    )? getDiscountDescription,
    Widget Function(
      BuildContext context,
      ProductPageProduct product,
    )? productPopupBuilder,
    Widget Function(
      BuildContext context,
    )? noContentBuilder,
    Widget Function(
      BuildContext context,
      Object? error,
      StackTrace? stackTrace,
    )? errorBuilder,
  }) {
    _productPopupBuilder = productPopupBuilder;
    _productPopupBuilder ??=
        (BuildContext context, ProductPageProduct product) => ProductItemPopup(
              product: product,
              configuration: this,
            );

    _onProductDetail = onProductDetail;
    _onProductDetail ??=
        (BuildContext context, ProductPageProduct product) async {
      var theme = Theme.of(context);

      await showModalBottomSheet(
        context: context,
        backgroundColor: theme.colorScheme.surface,
        builder: (context) => _productPopupBuilder!(
          context,
          product,
        ),
      );
    };

    _noContentBuilder = noContentBuilder;
    _noContentBuilder ??= (BuildContext context) {
      var theme = Theme.of(context);
      return Center(
        child: Text(
          "No content",
          style: theme.textTheme.titleLarge,
        ),
      );
    };

    _errorBuilder = errorBuilder;
    _errorBuilder ??=
        (BuildContext context, Object? error, StackTrace? stackTrace) {
      var theme = Theme.of(context);
      return Center(
        child: Text(
          "Error: $error",
          style: theme.textTheme.titleLarge,
        ),
      );
    };

    _getDiscountDescription = getDiscountDescription;
    _getDiscountDescription ??=
        (ProductPageProduct product) => "${product.name} is on sale!";
  }

  /// The shop that is initially selected.
  final String? initialShopId;

  /// A list of all the shops that the user must be able to navigate from.
  final Future<List<ProductPageShop>> shops;

  /// A function that returns all the products that belong to a certain shop.
  /// The function must return a [ProductPageContent] object.
  final Future<ProductPageContent> Function(ProductPageShop shop) getProducts;

  /// The localizations for the product page.
  final ProductPageLocalization localizations;

  /// Builder for the product item. These items will be displayed in the list
  /// for each product in their seperated category. This builder should only
  /// build the widget for one specific product. This builder has a default
  /// in-case the developer does not override it.
  Widget Function(BuildContext context, ProductPageProduct product)?
      productBuilder;

  late Widget Function(BuildContext context, ProductPageProduct product)?
      _productPopupBuilder;

  /// The builder for the product popup. This popup will be displayed when the
  /// user clicks on a product. This builder should only build the widget that
  /// displays the content of one specific product.
  /// This builder has a default in-case the developer
  Widget Function(BuildContext context, ProductPageProduct product)
      get productPopupBuilder => _productPopupBuilder!;

  late Function(BuildContext context, ProductPageProduct product)?
      _onProductDetail;

  /// This function handles the creation of the product detail popup. This
  /// function has a default in-case the developer does not override it.
  /// The default intraction is a popup, but this can be overriden.
  Function(BuildContext context, ProductPageProduct product)
      get onProductDetail => _onProductDetail!;

  late Widget Function(BuildContext context)? _noContentBuilder;

  /// The no content builder is used when a shop has no products. This builder
  /// has a default in-case the developer does not override it.
  Function(BuildContext context)? get noContentBuilder => _noContentBuilder;

  /// The builder for the shopping cart. This builder should return a widget
  /// that navigates to the shopping cart overview page.
  Widget Function(BuildContext context)? navigateToShoppingCartBuilder;

  late Widget Function(
    BuildContext context,
    Object? error,
    StackTrace? stackTrace,
  )? _errorBuilder;

  /// The error builder is used when an error occurs. This builder has a default
  /// in-case the developer does not override it.
  Widget Function(BuildContext context, Object? error, StackTrace? stackTrace)?
      get errorBuilder => _errorBuilder;

  late String Function(ProductPageProduct product)? _getDiscountDescription;

  /// The function that returns the description of the discount for a product.
  /// This allows you to translate and give custom messages for each product.
  String Function(ProductPageProduct product)? get getDiscountDescription =>
      _getDiscountDescription!;

  /// This function must be implemented by the developer and should handle the
  /// adding of a product to the cart.
  Function(ProductPageProduct product) onAddToCart;

  /// This function gets executed when the user changes the shop selection.
  /// This function always fires upon first load with the initial shop as well.
  final Function(ProductPageShop shop)? onShopSelectionChange;

  /// This function must be implemented by the developer and should handle the
  /// navigation to the shopping cart overview page.
  final int Function()? getProductsInShoppingCart;

  /// This function must be implemented by the developer and should handle the
  /// navigation to the shopping cart overview page.
  final Function() onNavigateToShoppingCart;

  /// The style of the shop selector.
  final ShopSelectorStyle shopSelectorStyle;

  /// The styling configuration for the category list.
  final ProductPageCategoryStylingConfiguration categoryStylingConfiguration;

  /// The padding for the page.
  final EdgeInsets pagePadding;

  /// Optional app bar that you can pass to the product page screen.
  final Widget? bottomNavigationBar;

  /// Optional app bar that you can pass to the order detail screen.
  final PreferredSizeWidget? appBar;
}
