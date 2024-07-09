import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";
import "package:flutter_product_page/src/services/category_service.dart";
import "package:flutter_product_page/src/widgets/defaults/default_appbar.dart";
import "package:flutter_product_page/src/widgets/defaults/default_error.dart";
import "package:flutter_product_page/src/widgets/defaults/default_no_content.dart";
import "package:flutter_product_page/src/widgets/defaults/default_shopping_cart_button.dart";
import "package:flutter_product_page/src/widgets/defaults/selected_categories.dart";
import "package:flutter_product_page/src/widgets/shop_selector.dart";
import "package:flutter_product_page/src/widgets/weekly_discount.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// A page that displays products.
class ProductPageScreen extends StatefulWidget {
  /// Constructor for the product page.
  const ProductPageScreen({
    required this.configuration,
    super.key,
  });

  /// Configuration for the product page.
  final ProductPageConfiguration configuration;

  @override
  State<ProductPageScreen> createState() => _ProductPageScreenState();
}

class _ProductPageScreenState extends State<ProductPageScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: widget.configuration.appBarBuilder?.call(context) ??
            DefaultAppbar(
              configuration: widget.configuration,
            ),
        bottomNavigationBar: widget.configuration.bottomNavigationBar,
        body: SafeArea(
          child: Padding(
            padding: widget.configuration.pagePadding,
            child: FutureBuilder(
              // ignore: discarded_futures
              future: widget.configuration.shops(),
              builder: (context, snapshot) {
                List<Shop>? shops;

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: CircularProgressIndicator.adaptive()),
                    ],
                  );
                }

                if (snapshot.hasError) {
                  return widget.configuration.errorBuilder?.call(
                        context,
                        snapshot.error,
                      ) ??
                      DefaultError(
                        error: snapshot.error,
                      );
                }

                shops = snapshot.data;

                if (shops == null || shops.isEmpty) {
                  return widget.configuration.errorBuilder?.call(
                        context,
                        snapshot.error,
                      ) ??
                      DefaultError(error: snapshot.error);
                }

                if (widget.configuration.initialShopId != null) {
                  var initialShop = shops.firstWhereOrNull(
                    (shop) => shop.id == widget.configuration.initialShopId,
                  );
                  if (initialShop != null) {
                    widget.configuration.shoppingService.shopService.selectShop(
                      initialShop,
                    );
                  } else {
                    widget.configuration.shoppingService.shopService.selectShop(
                      shops.first,
                    );
                  }
                } else {
                  widget.configuration.shoppingService.shopService.selectShop(
                    shops.first,
                  );
                }
                return _ProductPageContent(
                  configuration: widget.configuration,
                  shops: shops,
                );
              },
            ),
          ),
        ),
      );
}

class _ProductPageContent extends StatefulWidget {
  const _ProductPageContent({
    required this.configuration,
    required this.shops,
  });

  final ProductPageConfiguration configuration;

  final List<Shop> shops;

  @override
  State<_ProductPageContent> createState() => _ProductPageContentState();
}

class _ProductPageContentState extends State<_ProductPageContent> {
  @override
  Widget build(BuildContext context) => Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // shop selector
                widget.configuration.shopselectorBuilder?.call(
                      context,
                      widget.configuration,
                      widget.shops,
                      widget
                          .configuration.shoppingService.shopService.selectShop,
                    ) ??
                    ShopSelector(
                      configuration: widget.configuration,
                      shops: widget.shops,
                      onTap: (shop) {
                        widget.configuration.shoppingService.shopService
                            .selectShop(shop);
                      },
                    ),
                // selected categories
                widget.configuration.selectedCategoryBuilder?.call(
                      widget.configuration,
                    ) ??
                    SelectedCategories(
                      configuration: widget.configuration,
                    ),
                // products
                _ShopContents(
                  configuration: widget.configuration,
                ),
              ],
            ),
          ),

          // button
          Align(
            alignment: Alignment.bottomCenter,
            child: widget.configuration.shoppingCartButtonBuilder != null
                ? widget.configuration.shoppingCartButtonBuilder!(
                    context,
                    widget.configuration,
                  )
                : DefaultShoppingCartButton(
                    configuration: widget.configuration,
                  ),
          ),
        ],
      );
}

class _ShopContents extends StatefulWidget {
  const _ShopContents({
    required this.configuration,
  });

  final ProductPageConfiguration configuration;

  @override
  State<_ShopContents> createState() => _ShopContentsState();
}

class _ShopContentsState extends State<_ShopContents> {
  @override
  void initState() {
    widget.configuration.shoppingService.shopService.addListener(_listen);
    super.initState();
  }

  @override
  void dispose() {
    widget.configuration.shoppingService.shopService.removeListener(_listen);
    super.dispose();
  }

  void _listen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.configuration.pagePadding.horizontal,
      ),
      child: FutureBuilder(
        // ignore: discarded_futures
        future: widget.configuration.getProducts(
          widget.configuration.shoppingService.shopService.selectedShop!,
        ),
        builder: (context, snapshot) {
          List<Product> productPageContent;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }

          if (snapshot.hasError) {
            if (widget.configuration.errorBuilder != null) {
              return widget.configuration.errorBuilder!(
                context,
                snapshot.error,
              );
            } else {
              return DefaultError(error: snapshot.error);
            }
          }

          productPageContent =
              widget.configuration.shoppingService.productService.products;

          if (productPageContent.isEmpty) {
            return widget.configuration.noContentBuilder?.call(context) ??
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
                widget.configuration.discountBuilder?.call(
                      context,
                      widget.configuration,
                      discountedproducts,
                    ) ??
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: WeeklyDiscount(
                        configuration: widget.configuration,
                        product: discountedproducts.first,
                      ),
                    ),
              ],
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Text(
                  widget.configuration.translations.categoryItemListTitle,
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.start,
                ),
              ),

              widget.configuration.categoryListBuilder?.call(
                    context,
                    widget.configuration,
                    productPageContent,
                  ) ??
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: Column(
                      children: [
                        // Products

                        getCategoryList(
                          context,
                          widget.configuration,
                          widget.configuration.shoppingService.productService
                              .products,
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
