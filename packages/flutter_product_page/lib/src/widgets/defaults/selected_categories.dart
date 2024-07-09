import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";

/// Selected categories.
class SelectedCategories extends StatefulWidget {
  /// Constructor for the selected categories.
  const SelectedCategories({
    required this.configuration,
    super.key,
  });

  /// Configuration for the product page.
  final ProductPageConfiguration configuration;

  @override
  State<SelectedCategories> createState() => _SelectedCategoriesState();
}

class _SelectedCategoriesState extends State<SelectedCategories> {
  @override
  void initState() {
    widget.configuration.shoppingService.productService.addListener(_listen);
    super.initState();
  }

  @override
  void dispose() {
    widget.configuration.shoppingService.productService.removeListener(_listen);
    super.dispose();
  }

  void _listen() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var category in widget.configuration.shoppingService
                .productService.selectedCategories) ...[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Chip(
                  backgroundColor: theme.colorScheme.primary,
                  deleteIcon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onDeleted: () {
                    widget.configuration.shoppingService.productService
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
    );
  }
}
