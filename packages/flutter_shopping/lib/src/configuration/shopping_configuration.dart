import "package:flutter/material.dart";
import "package:flutter_shopping/flutter_shopping.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// configuration for the shopping userstory
class ShoppingConfiguration {
  /// constructor for the userstory configuration
  const ShoppingConfiguration({
    /// ProductPage configurations
    required this.shoppingService,
    this.onGetProducts,
    this.onGetShops,
    this.onAddToCart,
    this.onNavigateToShoppingCart,
    this.getProductsInShoppingCart,
    this.shoppingCartButtonBuilder,
    this.initialShopid,
    this.productBuilder,
    this.onShopSelectionChange,
    this.productPageTranslations,
    this.shopSelectorStyle,
    this.productPagePagePadding,
    this.productPageAppBarBuilder,
    this.bottomNavigationBarBuilder,
    this.onProductDetail,
    this.discountDescription,
    this.noContentBuilder,
    this.errorBuilder,
    this.categoryListBuilder,
    this.shopselectorBuilder,
    this.discountBuilder,

    /// ShoppingCart configurations
    this.onConfirmOrder,
    this.productItemBuilder,
    this.confirmOrderButtonBuilder,
    this.confirmOrderButtonHeight,
    this.sumBottomSheetBuilder,
    this.sumBottomSheetHeight,
    this.titleBuilder,
    this.shoppingCartTranslations,
    this.shoppingCartPagePadding,
    this.shoppingCartBottomPadding,
    this.shoppingCartAppBarBuilder,

    /// OrderDetail configurations
    this.onNextStep,
    this.onStepsCompleted,
    this.onCompleteOrderDetails,
    this.pages,
    this.orderDetailTranslations,
    this.orderDetailAppBarBuilder,
    this.orderDetailNextbuttonBuilder,
    this.orderSuccessBuilder,
  });

  /// The service that will be used for the userstory
  final ShoppingService shoppingService;

  /// Function that will be called when the products are requested
  final Future<List<Product>> Function(String shopId)? onGetProducts;

  /// Function that will be called when the shops are requested
  final Future<List<Shop>> Function()? onGetShops;

  /// Function that will be called when an item is added to the shopping cart
  final Function(Product)? onAddToCart;

  /// Function that will be called when the user navigates to the shopping cart
  final Function()? onNavigateToShoppingCart;

  /// Function that will be called to get the amount of
  /// products in the shopping cart
  final int Function()? getProductsInShoppingCart;

  /// Default shopping cart button builder
  final Widget Function(BuildContext, ProductPageConfiguration)?
      shoppingCartButtonBuilder;

  /// Initial shop that will be selected
  final String? initialShopid;

  /// ProductPage item builder
  final Widget Function(
    BuildContext,
    Product,
    ProductPageConfiguration configuration,
  )? productBuilder;

  /// Function that will be called when the shop selection changes
  final Function(Shop)? onShopSelectionChange;

  /// Translations for the product page
  final ProductPageTranslations? productPageTranslations;

  /// Shop selector style
  final ShopSelectorStyle? shopSelectorStyle;

  /// ProductPage padding
  final EdgeInsets? productPagePagePadding;

  /// AppBar builder
  final AppBar Function(BuildContext)? productPageAppBarBuilder;

  /// BottomNavigationBarBuilder
  final Widget? bottomNavigationBarBuilder;

  /// Function that will be called when the product detail is requested
  final Function(BuildContext, Product, String)? onProductDetail;

  /// Function that will be called when the discount description is requested
  final String Function(Product)? discountDescription;

  /// Function that will be called when there are no products
  final Widget Function(BuildContext)? noContentBuilder;

  /// Function that will be called when there is an error
  final Widget Function(BuildContext, Object?)? errorBuilder;

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

  /// Function that will be called when the order button on
  /// the shopping cart page is pressed
  final Function(List<Product>)? onConfirmOrder;

  /// Shopping cart item builder
  final Widget Function(BuildContext, Product, ShoppingCartConfig)?
      productItemBuilder;

  /// Shopping cart confirm order button builder
  final Widget Function(
    BuildContext,
    ShoppingCartConfig,
    dynamic Function(List<Product>),
  )? confirmOrderButtonBuilder;

  /// The height of the confirm order button
  /// This will not set the height of the button itself
  /// this is only used to create some extra space on the bottom
  /// of the product list so the button doesn't overlap with the
  /// last product
  final double? confirmOrderButtonHeight;

  /// Shopping cart sum bottom sheet builder
  final Widget Function(BuildContext, ShoppingCartConfig)?
      sumBottomSheetBuilder;

  /// The height of the sum bottom sheet
  /// This will not set the height of the sheet itself
  /// this is only used to create some extra space on the bottom
  /// of the product list so the sheet doesn't overlap with the
  /// last product
  final double? sumBottomSheetHeight;

  /// Function to override the title on the shopping cart screen
  final Widget Function(BuildContext, String)? titleBuilder;

  /// Shopping cart translations
  final ShoppingCartTranslations? shoppingCartTranslations;

  /// Shopping cart page padding
  final EdgeInsets? shoppingCartPagePadding;

  /// Shopping cart bottom padding
  final EdgeInsets? shoppingCartBottomPadding;

  /// Shopping cart app bar builder
  final AppBar Function(BuildContext)? shoppingCartAppBarBuilder;

  /// Function that gets called when the user navigates to the next
  /// step of the order details
  final dynamic Function(
    int,
    Map<String, dynamic>,
    FlutterFormController controller,
  )? onNextStep;

  /// Function that gets called when the Navigates
  /// to the order confirmationp page
  final dynamic Function(
    String,
    List<Product>,
    Map<int, Map<String, dynamic>>,
    OrderDetailConfiguration,
  )? onStepsCompleted;

  /// Function that gets called when pressing the complete order
  /// button on the confirmation page
  final Function(BuildContext, OrderDetailConfiguration)?
      onCompleteOrderDetails;

  /// The order detail pages that are used in the order detail screen
  final List<FlutterFormPage> Function(BuildContext)? pages;

  /// The translations for the order detail screen
  final OrderDetailTranslations? orderDetailTranslations;

  /// The app bar for the order detail screen
  final AppBar Function(BuildContext, String)? orderDetailAppBarBuilder;

  /// The builder for the next button on the order detail screen
  final Widget Function(
    int,
    // ignore: avoid_positional_boolean_parameters
    bool,
    BuildContext,
    OrderDetailConfiguration,
    FlutterFormController,
  )? orderDetailNextbuttonBuilder;

  /// The builder for the order success screen
  final Widget? Function(
    BuildContext,
    OrderDetailConfiguration,
    Map<int, Map<String, dynamic>>,
  )? orderSuccessBuilder;
}
