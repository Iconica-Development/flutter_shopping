import "package:collection/collection.dart";
import "package:flutter/material.dart";
import "package:flutter_shopping/flutter_shopping.dart";

/// The shopping screen.
class ShoppingScreen extends StatefulWidget {
  /// Constructor for the shopping screen.
  const ShoppingScreen({
    required this.shoppingService,
    required this.translations,
    required this.onShoppingCartPressed,
    required this.options,
    this.onFilterPressed,
    this.initialShopId,
    super.key,
  });

  /// The shopping service.
  final ShoppingService shoppingService;

  /// The translations.
  final ShoppingTranslations translations;

  /// The initial shop id.
  final String? initialShopId;

  /// The on filter pressed function.
  final Function()? onFilterPressed;

  /// The on shopping cart pressed function.
  final Function() onShoppingCartPressed;

  /// The options for shopping.
  final FlutterShoppingOptions options;

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  Shop? selectedShop;
  List<Category> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var service = widget.shoppingService;
    var options = widget.options;
    return Scaffold(
      drawer: options.shoppingScreenDrawer,
      appBar: options.shoppingScreenAppbarBuilder?.call(
            context,
            selectedShop?.adress ?? "",
            widget.onFilterPressed,
          ) ??
          AppBar(
            title: Text(
              selectedShop?.adress ?? "",
              style: theme.textTheme.headlineLarge,
            ),
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person_rounded,
                size: 28,
              ),
            ),
            actions: [
              IconButton(
                onPressed: widget.onFilterPressed,
                icon: const Icon(
                  Icons.filter_alt_rounded,
                  size: 28,
                ),
              ),
            ],
          ),
      body: Stack(
        children: [
          StreamBuilder(
            stream: widget.shoppingService.getShops(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                selectedShop ??= widget.shoppingService.selectShop(
                  widget.initialShopId ?? snapshot.data!.first.id,
                );
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ShopSelector(
                          shops: snapshot.data!,
                          options: options,
                          shoppingService: widget.shoppingService,
                          onSelected: (shop) {
                            service.selectShop(shop.id);
                            setState(() {
                              selectedShop = shop;
                            });
                          },
                        ),
                      ),
                      StreamBuilder(
                        stream: service.getSelectedCategoryStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            selectedCategories = snapshot.data!;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Wrap(
                                spacing: 8,
                                children: snapshot.data!
                                    .map(
                                      (category) =>
                                          options.filterChipbuilder?.call(
                                              context, category.name, () {
                                            service
                                                .deselectCategory(category.id);
                                          }) ??
                                          FilterChip(
                                            backgroundColor: theme.primaryColor,
                                            onSelected: (value) {},
                                            label: Text(
                                              category.name,
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: Colors.white,
                                              ),
                                            ),
                                            deleteIcon: const Icon(
                                              Icons.close_rounded,
                                              color: Colors.white,
                                            ),
                                            onDeleted: () {
                                              service.deselectCategory(
                                                category.id,
                                              );
                                            },
                                          ),
                                    )
                                    .toList(),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                      StreamBuilder(
                        stream: widget.shoppingService
                            .getProducts(selectedShop!.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var products = groupBy(
                              snapshot.data!,
                              (Product p) => p.category,
                            );
                            var weeklyOffer = service.getWeeklyOffer();
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 20,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if (weeklyOffer != null) ...[
                                    options.weeklyOfferBuilder?.call(
                                          context,
                                          weeklyOffer,
                                        ) ??
                                        WeeklyOffer(
                                          product: weeklyOffer,
                                          translations: widget.translations,
                                        ),
                                  ],
                                  Row(
                                    children: [
                                      Text(
                                        widget.translations
                                            .whatWouldyouLikeToOrder,
                                        style: theme.textTheme.titleLarge,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20,
                                      bottom: 100,
                                    ),
                                    child: ProductItemList(
                                      options: widget.options,
                                      translations: widget.translations,
                                      products: products,
                                      onAddToCart: (product) async {
                                        await service.addProductToCart(product);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          StreamBuilder(
            stream: service.getCartLength(),
            builder: (context, snapshot) {
              var cartLength = snapshot.data ?? 0;
              return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: options.primaryButtonBuilder?.call(
                          context,
                          cartLength > 0,
                          widget.translations.viewShoppingCart, () {
                        widget.onShoppingCartPressed();
                      }) ??
                      PrimaryButton(
                        enabled: cartLength > 0,
                        text: widget.translations.viewShoppingCart,
                        onPressed: widget.onShoppingCartPressed,
                      ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
