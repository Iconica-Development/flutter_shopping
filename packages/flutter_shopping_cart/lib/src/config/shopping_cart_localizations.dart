import "package:flutter/material.dart";

/// Shopping cart localizations
class ShoppingCartLocalizations {
  /// Creates shopping cart localizations
  const ShoppingCartLocalizations({
    this.locale = const Locale("en", "US"),
    this.placeOrder = "PLACE ORDER",
    this.sum = "Total:",
  });

  /// Locale for the shopping cart.
  /// This locale will be used to format the currency.
  /// Default is English.
  final Locale locale;

  /// Localization for the place order button.
  /// This text will only be displayed if you're not using the place order
  /// button builder.
  final String placeOrder;

  /// Localization for the sum.
  final String sum;
}
