import "package:flutter/material.dart";
import "package:flutter_nested_categories/flutter_nested_categories.dart";
import "package:flutter_product_page/src/services/shopping_cart_notifier.dart";
import "package:flutter_product_page/src/ui/components/product_item.dart";
import "package:flutter_shopping/flutter_shopping.dart";

/// A function that is called when a product is added to the cart.
Product onAddToCartWrapper(
  ProductPageConfiguration configuration,
  ShoppingCartNotifier shoppingCartNotifier,
  Product product,
) {
  shoppingCartNotifier.productsChanged();

  configuration.onAddToCart(product);

  return product;
}

/// Generates a [CategoryList] from a list of [Product]s and a
/// [ProductPageConfiguration].
Widget getCategoryList(
  BuildContext context,
  ProductPageConfiguration configuration,
  ShoppingCartNotifier shoppingCartNotifier,
  List<Product> products,
) {
  var theme = Theme.of(context);
  var categorizedProducts = <String, List<Product>>{};
  for (var product in products) {
    if (!categorizedProducts.containsKey(product.category)) {
      categorizedProducts[product.category] = [];
    }
    categorizedProducts[product.category]?.add(product);
  }

  // Create Category instances
  var categories = <Category>[];
  categorizedProducts.forEach((categoryName, productList) {
    var productWidgets = productList
        .map(
          (product) => configuration.productBuilder != null
              ? configuration.productBuilder!(context, product)
              : ProductItem(
                  product: product,
                  onProductDetail: configuration.onProductDetail,
                  onAddToCart: (Product product) => onAddToCartWrapper(
                    configuration,
                    shoppingCartNotifier,
                    product,
                  ),
                  localizations: configuration.localizations,
                ),
        )
        .toList();
    var category = Category(
      name: categoryName,
      content: productWidgets,
    );
    categories.add(category);
  });
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (var category in categories) ...[
        Text(
          category.name!,
          style: theme.textTheme.titleMedium,
        ),
        Column(
          children: category.content,
        ),
        const SizedBox(height: 16),
      ],
    ],
  );
}