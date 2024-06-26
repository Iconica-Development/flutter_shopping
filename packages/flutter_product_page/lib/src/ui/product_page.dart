import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";
import "package:flutter_product_page/src/services/category_service.dart";
import "package:flutter_product_page/src/services/selected_shop_service.dart";
import "package:flutter_product_page/src/services/shopping_cart_notifier.dart";
import "package:flutter_product_page/src/ui/components/shop_selector.dart";
import "package:flutter_product_page/src/ui/components/weekly_discount.dart";

/// A page that displays products.
class ProductPage extends StatelessWidget {
  /// Constructor for the product page.
  ProductPage({
    required this.configuration,
    this.initialBuildShopId,
    super.key,
  });

  /// Configuration for the product page.
  final ProductPageConfiguration configuration;

  /// An optional initial shop ID to select. This overrides the initialShopId
  /// from the configuration.
  final String? initialBuildShopId;

  late final SelectedShopService _selectedShopService = SelectedShopService();

  late final ShoppingCartNotifier _shoppingCartNotifier =
      ShoppingCartNotifier();

  @override
  Widget build(BuildContext context) => Padding(
        padding: configuration.pagePadding,
        child: FutureBuilder(
          future: configuration.shops,
          builder: (BuildContext context, AsyncSnapshot data) {
            if (data.connectionState == ConnectionState.waiting) {
              return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (data.hasError) {
              return configuration.errorBuilder!(
                context,
                data.error,
                data.stackTrace,
              );
            }

            List<ProductPageShop>? shops = data.data;

            if (shops == null || shops.isEmpty) {
              return configuration.errorBuilder!(context, null, null);
            }

            if (initialBuildShopId != null) {
              ProductPageShop? initialShop;

              for (var shop in shops) {
                if (shop.id == initialBuildShopId) {
                  initialShop = shop;
                  break;
                }
              }

              _selectedShopService.selectShop(initialShop ?? shops.first);
            } else if (configuration.initialShopId != null) {
              ProductPageShop? initialShop;

              for (var shop in shops) {
                if (shop.id == configuration.initialShopId) {
                  initialShop = shop;
                  break;
                }
              }

              _selectedShopService.selectShop(initialShop ?? shops.first);
            } else {
              _selectedShopService.selectShop(shops.first);
            }

            return ListenableBuilder(
              listenable: _selectedShopService,
              builder: (BuildContext context, Widget? _) {
                configuration.onShopSelectionChange?.call(
                  _selectedShopService.selectedShop!,
                );
                return _ProductPage(
                  configuration: configuration,
                  selectedShopService: _selectedShopService,
                  shoppingCartNotifier: _shoppingCartNotifier,
                  shops: shops,
                );
              },
            );
          },
        ),
      );
}

class _ProductPage extends StatelessWidget {
  const _ProductPage({
    required this.configuration,
    required this.selectedShopService,
    required this.shoppingCartNotifier,
    required this.shops,
  });

  final ProductPageConfiguration configuration;
  final SelectedShopService selectedShopService;
  final ShoppingCartNotifier shoppingCartNotifier;

  final List<ProductPageShop> shops;

  void _onTapChangeShop(ProductPageShop shop) {
    selectedShopService.selectShop(shop);
  }

  @override
  Widget build(BuildContext context) {
    var pageContent = SingleChildScrollView(
      child: Column(
        children: [
          ShopSelector(
            configuration: configuration,
            selectedShopService: selectedShopService,
            shops: shops,
            onTap: _onTapChangeShop,
          ),
          _ShopContents(
            configuration: configuration,
            selectedShopService: selectedShopService,
            shoppingCartNotifier: shoppingCartNotifier,
          ),
        ],
      ),
    );

    return Stack(
      children: [
        pageContent,
        Align(
          alignment: Alignment.bottomCenter,
          child: configuration.navigateToShoppingCartBuilder != null
              ? configuration.navigateToShoppingCartBuilder!(context)
              : _NavigateToShoppingCartButton(
                  configuration: configuration,
                  shoppingCartNotifier: shoppingCartNotifier,
                ),
        ),
      ],
    );
  }
}

class _NavigateToShoppingCartButton extends StatelessWidget {
  const _NavigateToShoppingCartButton({
    required this.configuration,
    required this.shoppingCartNotifier,
  });

  final ProductPageConfiguration configuration;
  final ShoppingCartNotifier shoppingCartNotifier;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    String getProductsInShoppingCartLabel() {
      var fun = configuration.getProductsInShoppingCart;

      if (fun == null) {
        return "";
      }

      return "(${fun()})";
    }

    return FilledButton(
      onPressed: configuration.onNavigateToShoppingCart,
      style: theme.filledButtonTheme.style?.copyWith(
        backgroundColor: WidgetStateProperty.all(
          theme.colorScheme.primary,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: ListenableBuilder(
          listenable: shoppingCartNotifier,
          builder: (BuildContext context, Widget? _) => Text(
            """${configuration.localizations.navigateToShoppingCart.toUpperCase()} ${getProductsInShoppingCartLabel()}""",
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _ShopContents extends StatelessWidget {
  const _ShopContents({
    required this.configuration,
    required this.selectedShopService,
    required this.shoppingCartNotifier,
  });

  final ProductPageConfiguration configuration;
  final SelectedShopService selectedShopService;
  final ShoppingCartNotifier shoppingCartNotifier;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: configuration.pagePadding.horizontal,
        ),
        child: FutureBuilder(
          // ignore: discarded_futures
          future: configuration.getProducts(
            selectedShopService.selectedShop!,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (snapshot.hasError) {
              return configuration.errorBuilder!(
                context,
                snapshot.error,
                snapshot.stackTrace,
              );
            }

            var productPageContent = snapshot.data;

            if (productPageContent == null ||
                productPageContent.products.isEmpty) {
              return configuration.noContentBuilder!(context);
            }

            var productList = Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Column(
                children: [
                  // Products
                  getCategoryList(
                    context,
                    configuration,
                    shoppingCartNotifier,
                    productPageContent.products,
                  ),

                  // Bottom padding so the last product is not cut off
                  // by the to shopping cart button.
                  const SizedBox(height: 48),
                ],
              ),
            );

            return Column(
              children: [
                // Discounted product
                if (productPageContent.discountedProduct != null) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: WeeklyDiscount(
                      configuration: configuration,
                      product: productPageContent.discountedProduct!,
                    ),
                  ),
                ],

                productList,
              ],
            );
          },
        ),
      );
}
