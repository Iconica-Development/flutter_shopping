import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";
import "package:flutter_product_page/src/services/category_service.dart";
import "package:flutter_product_page/src/widgets/defaults/default_appbar.dart";
import "package:flutter_product_page/src/widgets/defaults/default_error.dart";
import "package:flutter_product_page/src/widgets/defaults/default_no_content.dart";
import "package:flutter_product_page/src/widgets/defaults/default_shopping_cart_button.dart";
import "package:flutter_product_page/src/widgets/shop_selector.dart";
import "package:flutter_product_page/src/widgets/weekly_discount.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// A page that displays products.
class ProductPageScreen extends StatelessWidget {
  /// Constructor for the product page.
  const ProductPageScreen({
    required this.configuration,
    this.initialBuildShopId,
    super.key,
  });

  /// Configuration for the product page.
  final ProductPageConfiguration configuration;

  /// An optional initial shop ID to select. This overrides the initialShopId
  /// from the configuration.
  final String? initialBuildShopId;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: configuration.appBarBuilder?.call(context) ??
            DefaultAppbar(
              configuration: configuration,
            ),
        bottomNavigationBar: configuration.bottomNavigationBar,
        body: SafeArea(
          child: Padding(
            padding: configuration.pagePadding,
            child: FutureBuilder(
              // ignore: discarded_futures
              future: configuration.shops(),
              builder: (BuildContext context, AsyncSnapshot data) {
                if (data.connectionState == ConnectionState.waiting) {
                  return const Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: CircularProgressIndicator.adaptive()),
                    ],
                  );
                }

                if (data.hasError) {
                  return configuration.errorBuilder?.call(
                        context,
                        data.error,
                      ) ??
                      DefaultError(error: data.error);
                }

                List<Shop>? shops = data.data;

                if (shops == null || shops.isEmpty) {
                  return configuration.errorBuilder?.call(
                        context,
                        data.error,
                      ) ??
                      DefaultError(error: data.error);
                }

                if (initialBuildShopId != null) {
                  Shop? initialShop;

                  for (var shop in shops) {
                    if (shop.id == initialBuildShopId) {
                      initialShop = shop;
                      break;
                    }
                  }

                  configuration.shoppingService.shopService
                      .selectShop(initialShop ?? shops.first);
                } else if (configuration.initialShopId != null) {
                  Shop? initialShop;

                  for (var shop in shops) {
                    if (shop.id == configuration.initialShopId) {
                      initialShop = shop;
                      break;
                    }
                  }

                  configuration.shoppingService.shopService
                      .selectShop(initialShop ?? shops.first);
                } else {
                  configuration.shoppingService.shopService
                      .selectShop(shops.first);
                }

                return ListenableBuilder(
                  listenable: configuration.shoppingService.shopService,
                  builder: (BuildContext context, Widget? _) {
                    configuration.onShopSelectionChange?.call(
                      configuration.shoppingService.shopService.selectedShop!,
                    );
                    return _ProductPage(
                      configuration: configuration,
                      shops: shops,
                    );
                  },
                );
              },
            ),
          ),
        ),
      );
}

class _ProductPage extends StatelessWidget {
  const _ProductPage({
    required this.configuration,
    required this.shops,
  });

  final ProductPageConfiguration configuration;

  final List<Shop> shops;

  @override
  Widget build(BuildContext context) {
    var pageContent = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          configuration.shopselectorBuilder?.call(
                context,
                configuration,
                shops,
                configuration.shoppingService.shopService.selectShop,
              ) ??
              ShopSelector(
                configuration: configuration,
                shops: shops,
                onTap: configuration.shoppingService.shopService.selectShop,
              ),
          configuration.selectedCategoryBuilder?.call(
                configuration,
              ) ??
              SelectedCategories(
                configuration: configuration,
              ),
          _ShopContents(
            configuration: configuration,
          ),
        ],
      ),
    );

    return Stack(
      children: [
        pageContent,
        Align(
          alignment: Alignment.bottomCenter,
          child: configuration.shoppingCartButtonBuilder != null
              ? configuration.shoppingCartButtonBuilder!(
                  context,
                  configuration,
                )
              : DefaultShoppingCartButton(
                  configuration: configuration,
                ),
        ),
      ],
    );
  }
}

class _ShopContents extends StatelessWidget {
  const _ShopContents({
    required this.configuration,
  });

  final ProductPageConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: configuration.pagePadding.horizontal,
      ),
      child: FutureBuilder(
        // ignore: discarded_futures
        future: configuration.getProducts(
          configuration.shoppingService.shopService.selectedShop!,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            if (configuration.errorBuilder != null) {
              return configuration.errorBuilder!(
                context,
                snapshot.error,
              );
            } else {
              return DefaultError(error: snapshot.error);
            }
          }

          List<Product> productPageContent;

          productPageContent =
              configuration.shoppingService.productService.products;

          if (productPageContent.isEmpty) {
            return configuration.noContentBuilder?.call(context) ??
                const DefaultNoContent();
          }

          var discountedproducts = productPageContent
              .where((product) => product.hasDiscount)
              .toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Discounted product
              if (discountedproducts.isNotEmpty) ...[
                configuration.discountBuilder?.call(
                      context,
                      configuration,
                      discountedproducts,
                    ) ??
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: WeeklyDiscount(
                        configuration: configuration,
                        product: discountedproducts.first,
                      ),
                    ),
              ],
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Text(
                  configuration.translations.categoryItemListTitle,
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.start,
                ),
              ),

              configuration.categoryListBuilder?.call(
                    context,
                    configuration,
                    productPageContent,
                  ) ??
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Column(
                      children: [
                        // Products

                        ListenableBuilder(
                          listenable:
                              configuration.shoppingService.productService,
                          builder: (context, _) => getCategoryList(
                            context,
                            configuration,
                            configuration
                                .shoppingService.productService.products,
                          ),
                        ),

                        // Bottom padding so the last product is not cut off
                        // by the to shopping cart button.
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}

/// Selected categories.
class SelectedCategories extends StatelessWidget {
  /// Constructor for the selected categories.
  const SelectedCategories({
    required this.configuration,
    super.key,
  });

  /// Configuration for the product page.
  final ProductPageConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListenableBuilder(
      listenable: configuration.shoppingService.productService,
      builder: (context, _) => Padding(
        padding: const EdgeInsets.only(left: 4),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var category in configuration
                  .shoppingService.productService.selectedCategories) ...[
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Chip(
                    backgroundColor: theme.colorScheme.primary,
                    deleteIcon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onDeleted: () {
                      configuration.shoppingService.productService
                          .selectCategory(category);
                    },
                    label: Text(
                      category,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
