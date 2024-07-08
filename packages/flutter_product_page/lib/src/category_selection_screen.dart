import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";

/// Category selection screen.
class CategorySelectionScreen extends StatelessWidget {
  /// Constructor for the category selection screen.
  const CategorySelectionScreen({
    required this.configuration,
    super.key,
  });

  /// Configuration for the product page.
  final ProductPageConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        title: Text(
          "filter",
          style: theme.textTheme.headlineLarge,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: configuration.shoppingService.productService,
        builder: (context, _) => Column(
          children: [
            ...configuration.shoppingService.productService.getCategories().map(
              (category) {
                var isChecked = configuration
                    .shoppingService.productService.selectedCategories
                    .contains(category);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CheckboxListTile(
                    activeColor: theme.colorScheme.primary,
                    controlAffinity: ListTileControlAffinity.leading,
                    value: isChecked,
                    onChanged: (value) {
                      configuration.shoppingService.productService
                          .selectCategory(category);
                    },
                    shape: const UnderlineInputBorder(),
                    title: Text(
                      category,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
