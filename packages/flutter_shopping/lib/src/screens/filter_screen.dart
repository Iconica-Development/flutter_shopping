import "package:flutter/material.dart";
import "package:flutter_shopping/flutter_shopping.dart";
import "package:rxdart/rxdart.dart";

/// filter screen
class FilterScreen extends StatelessWidget {
  /// Constructor for the FilterScreen.
  const FilterScreen({
    required this.shoppingService,
    required this.translations,
    required this.options,
    super.key,
  });

  /// The shopping service.
  final ShoppingService shoppingService;

  /// The translations.
  final ShoppingTranslations translations;

  /// The options.
  final FlutterShoppingOptions options;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: options.filterScreenAppbarBuilder?.call(
              context,
              translations.filterTitle,
              () {
                Navigator.of(context).pop();
              },
            ) ??
            AppBar(
              leading: const SizedBox.shrink(),
              title: Text(translations.filterTitle),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 28,
                  ),
                ),
              ],
            ),
        body: SingleChildScrollView(
          child: StreamBuilder<List<dynamic>>(
            stream: Rx.combineLatest(
              [
                shoppingService.getCategories(),
                shoppingService.getSelectedCategoryStream(),
              ],
              (List<dynamic> data) => data,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var categories = snapshot.data![0] as List<Category>;
                var selectedCategories = snapshot.data![1] as List<Category>;

                return Column(
                  children: [
                    ...categories.map(
                      (category) {
                        var isSelected = containsCategoryById(
                          selectedCategories,
                          category.id,
                        );
                        return options.filterItemBuilder?.call(
                              context,
                              () {
                                shoppingService.deselectCategory(category.id);
                              },
                              () {
                                shoppingService.selectCategory(category.id);
                              },
                              isSelected,
                            ) ??
                            FilterItem(
                              value: isSelected,
                              onChanged: (value) {
                                if (value) {
                                  shoppingService.selectCategory(category.id);
                                } else {
                                  shoppingService.deselectCategory(category.id);
                                }
                              },
                              category: category,
                            );
                      },
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      );
}

/// Check if the category is selected.
bool containsCategoryById(List<Category> categories, String id) =>
    categories.any((category) => category.id == id);
