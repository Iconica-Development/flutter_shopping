import "package:flutter/material.dart";
import "package:flutter_shopping/flutter_shopping.dart";

/// A bottomsheet that shows information.
class InfoBottomsheet extends StatelessWidget {
  /// Constructor for the InfoBottomsheet.
  const InfoBottomsheet({
    required this.productInfo,
    required this.translations,
    super.key,
  });

  /// The product info.
  final String productInfo;

  /// The translations.
  final ShoppingTranslations translations;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Text(
            productInfo,
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: PrimaryButton(
            text: translations.closeInfo,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
