import "package:flutter/material.dart";
import "package:flutter_nested_categories/flutter_nested_categories.dart";
import "package:flutter_product_page/flutter_product_page.dart";
import "package:flutter_product_page/src/widgets/product_item.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// Generates a [CategoryList] from a list of [Product]s and a
/// [ProductPageConfiguration].
Widget getCategoryList(
  BuildContext context,
  ProductPageConfiguration configuration,
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
                  onAddToCart: (Product product) =>
                      configuration.onAddToCart(product),
                  translations: configuration.translations,
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
