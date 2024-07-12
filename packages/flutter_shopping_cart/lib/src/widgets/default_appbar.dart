import "package:flutter/material.dart";

/// Default appbar for the shopping cart.
class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructor for the default appbar for the shopping cart.
  const DefaultAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AppBar(
      title: Text(
        "Shopping cart",
        style: theme.textTheme.headlineLarge,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
