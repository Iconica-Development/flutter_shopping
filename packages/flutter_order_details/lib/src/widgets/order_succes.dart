import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";
import "package:flutter_shopping_interface/flutter_shopping_interface.dart";

/// Default order success widget.
class DefaultOrderSucces extends StatelessWidget {
  /// Constructor for the DefaultOrderSucces.
  const DefaultOrderSucces({
    required this.configuration,
    required this.orderDetails,
    super.key,
  });

  /// Configuration for the user-stor
  final OrderDetailConfiguration configuration;

  /// Order details.
  final Map<int, Map<String, dynamic>> orderDetails;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var discountedProducts = configuration
        .shoppingService.productService.products
        .where((product) => product.hasDiscount)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirmation",
          style: theme.textTheme.headlineLarge,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 32,
                top: 32,
                right: 32,
              ),
              child: Column(
                children: [
                  Text(
                    "Success!",
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Thank you ${orderDetails[0]!['name']} for your order!",
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "The order was placed"
                    // ignore: lines_longer_than_80_chars
                    " at ${configuration.shoppingService.shopService.selectedShop?.name}."
                    " You can pick this"
                    " up ${orderDetails[1]!['date']} at"
                    " ${orderDetails[1]!['multipleChoice']}.",
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "If you want, you can place another order in this street.",
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    "Weekly offers",
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 272,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 32),
                  // _discount(context),
                  // const SizedBox(width: 8),
                  // _discount(context),
                  for (var product in discountedProducts) ...[
                    _discount(
                      context,
                      product,
                      configuration.shoppingService.shopService.selectedShop!,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                  const SizedBox(width: 32),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    configuration.onCompleteOrderDetails
                        .call(context, configuration);
                  },
                  style: theme.filledButtonTheme.style?.copyWith(
                    backgroundColor: WidgetStateProperty.all(
                      theme.colorScheme.primary,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12,
                    ),
                    child: Text(
                      "Place another order",
                      style: theme.textTheme.displayLarge,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _discount(BuildContext context, Product product, Shop shop) {
  var theme = Theme.of(context);
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.black,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    width: MediaQuery.of(context).size.width - 64,
    height: 200,
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(
            10,
          ),
          child: Image.network(
            product.imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 38,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              shop.name,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            height: 68,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "${product.name}, now for ${product.price.toStringAsFixed(2)}",
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
