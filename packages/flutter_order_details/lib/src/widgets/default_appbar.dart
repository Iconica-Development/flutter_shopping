import "package:flutter/material.dart";

/// Default appbar for the order details page.
class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  /// Constructor for the default appbar for the order details page.
  const DefaultAppbar({
    required this.title,
    super.key,
  });

  /// Title of the appbar.
  final String title;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AppBar(
      title: Text(
        title,
        style: theme.textTheme.headlineLarge,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
