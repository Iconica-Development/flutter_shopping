// ignore_for_file: public_member_api_docs

import "package:flutter/material.dart";
import "package:flutter_shopping/flutter_shopping.dart";
import "package:flutter_shopping_local/flutter_shopping_local.dart";

class ShoppingNavigatorUserStory extends StatelessWidget {
  const ShoppingNavigatorUserStory({
    this.shoppingConfiguration,
    super.key,
  });

  final ShoppingConfiguration? shoppingConfiguration;

  @override
  Widget build(BuildContext context) => ShoppingProductPage(
        shoppingConfiguration: shoppingConfiguration ??
            ShoppingConfiguration(
              shoppingService: LocalShoppingService(),
            ),
      );
}

class ShoppingProductPage extends StatelessWidget {
  const ShoppingProductPage({
    required this.shoppingConfiguration,
    super.key,
  });
  final ShoppingConfiguration shoppingConfiguration;

  @override
  Widget build(BuildContext context) {
    var service = shoppingConfiguration.shoppingService;
    return ProductPageScreen(
      initialBuildShopId: shoppingConfiguration.initialShopid,
      configuration: ProductPageConfiguration(
        shoppingService: service,
        initialShopId: shoppingConfiguration.initialShopid,
        shoppingCartButtonBuilder:
            shoppingConfiguration.shoppingCartButtonBuilder,
        productBuilder: shoppingConfiguration.productBuilder,
        onShopSelectionChange: shoppingConfiguration.onShopSelectionChange,
        translations: shoppingConfiguration.productPageTranslations,
        shopSelectorStyle: shoppingConfiguration.shopSelectorStyle,
        pagePadding: shoppingConfiguration.productPagePagePadding,
        appBar: shoppingConfiguration.productPageAppBarBuilder,
        bottomNavigationBar: shoppingConfiguration.bottomNavigationBarBuilder,
        onProductDetail: shoppingConfiguration.onProductDetail,
        discountDescription: shoppingConfiguration.discountDescription,
        noContentBuilder: shoppingConfiguration.noContentBuilder,
        errorBuilder: shoppingConfiguration.errorBuilder,
        shops: () async {
          if (shoppingConfiguration.onGetShops != null) {
            return shoppingConfiguration.onGetShops!();
          } else {
            return service.shopService.getShops();
          }
        },
        getProducts: (shop) async {
          if (shoppingConfiguration.onGetProducts != null) {
            return shoppingConfiguration.onGetProducts!(shop.id);
          } else {
            return service.productService.getProducts(shop.id);
          }
        },
        onAddToCart: (product) {
          if (shoppingConfiguration.onAddToCart != null) {
            shoppingConfiguration.onAddToCart!(product);
            return;
          } else {
            return service.shoppingCartService.addProduct(product);
          }
        },
        onNavigateToShoppingCart: () async {
          if (shoppingConfiguration.onNavigateToShoppingCart != null) {
            return shoppingConfiguration.onNavigateToShoppingCart!();
          } else {
            return Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ShoppingCart(
                  shoppingConfiguration: shoppingConfiguration,
                ),
              ),
            );
          }
        },
        getProductsInShoppingCart: () {
          if (shoppingConfiguration.getProductsInShoppingCart != null) {
            return shoppingConfiguration.getProductsInShoppingCart!();
          } else {
            return service.shoppingCartService.countProducts();
          }
        },
      ),
    );
  }
}

class ShoppingCart extends StatelessWidget {
  const ShoppingCart({
    required this.shoppingConfiguration,
    super.key,
  });

  final ShoppingConfiguration shoppingConfiguration;

  @override
  Widget build(BuildContext context) {
    var service = shoppingConfiguration.shoppingService.shoppingCartService;
    return ShoppingCartScreen(
      configuration: ShoppingCartConfig(
        service: service,
        productItemBuilder: shoppingConfiguration.productItemBuilder,
        confirmOrderButtonBuilder:
            shoppingConfiguration.confirmOrderButtonBuilder,
        confirmOrderButtonHeight:
            shoppingConfiguration.confirmOrderButtonHeight,
        sumBottomSheetBuilder: shoppingConfiguration.sumBottomSheetBuilder,
        sumBottomSheetHeight: shoppingConfiguration.sumBottomSheetHeight,
        titleBuilder: shoppingConfiguration.titleBuilder,
        translations: shoppingConfiguration.shoppingCartTranslations,
        pagePadding: shoppingConfiguration.shoppingCartPagePadding,
        bottomPadding: shoppingConfiguration.shoppingCartBottomPadding,
        appBar: shoppingConfiguration.shoppingCartAppBarBuilder,
        onConfirmOrder: (products) async {
          if (shoppingConfiguration.onConfirmOrder != null) {
            return shoppingConfiguration.onConfirmOrder!(products);
          } else {
            return Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ShoppingOrderDetails(
                  shoppingConfiguration: shoppingConfiguration,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class ShoppingOrderDetails extends StatelessWidget {
  const ShoppingOrderDetails({
    required this.shoppingConfiguration,
    super.key,
  });

  final ShoppingConfiguration shoppingConfiguration;

  @override
  Widget build(BuildContext context) => OrderDetailScreen(
        configuration: OrderDetailConfiguration(
          shoppingService: shoppingConfiguration.shoppingService,
          pages: shoppingConfiguration.pages,
          translations: shoppingConfiguration.orderDetailTranslations,
          appBar: shoppingConfiguration.orderDetailAppBarBuilder,
          nextbuttonBuilder: shoppingConfiguration.orderDetailNextbuttonBuilder,
          orderSuccessBuilder: shoppingConfiguration.orderSuccessBuilder,
          onNextStep: (currentStep, data, controller) async {
            if (shoppingConfiguration.onNextStep != null) {
              return shoppingConfiguration.onNextStep!(
                currentStep,
                data,
                controller,
              );
            } else {
              await controller.autoNextStep();
            }
          },
          onStepsCompleted: (shopId, products, data, configuration) async {
            if (shoppingConfiguration.onStepsCompleted != null) {
              return shoppingConfiguration.onStepsCompleted!(
                shopId,
                products,
                data,
                configuration,
              );
            } else {
              return Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => DefaultOrderSucces(
                    configuration: configuration,
                    orderDetails: data,
                  ),
                ),
              );
            }
          },
          onCompleteOrderDetails: (context, configuration) async {
            if (shoppingConfiguration.onCompleteOrderDetails != null) {
              return shoppingConfiguration.onCompleteOrderDetails!(
                context,
                configuration,
              );
            } else {
              shoppingConfiguration.shoppingService.shoppingCartService.clear();
              return Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ShoppingProductPage(
                    shoppingConfiguration: shoppingConfiguration,
                  ),
                ),
              );
            }
          },
        ),
      );
}
