import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";

/// Default appbar for the product page.
class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructor for the default appbar for the product page.
  const DefaultAppbar({
    required this.configuration,
    super.key,
  });

  /// Configuration for the product page.
  final ProductPageConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return AppBar(
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt)),
      ],
      title: Text(
        configuration.translations.appBarTitle,
        style: theme.textTheme.headlineLarge,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
