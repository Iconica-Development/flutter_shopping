import "package:flutter/material.dart";

/// Default appbar for the product page.
class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructor for the default appbar for the product page.
  const DefaultAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return AppBar(
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.filter_alt)),
      ],
      title: Text(
        "Product page",
        style: theme.textTheme.headlineLarge,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
