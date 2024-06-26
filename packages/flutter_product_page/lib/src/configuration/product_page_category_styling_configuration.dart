import "package:flutter/material.dart";
import "package:flutter_nested_categories/flutter_nested_categories.dart"
    show CategoryHeaderStyling;

/// Configuration for the styling of the category list on the product page.
/// This configuration allows to customize the title, header styling and
/// the collapsible behavior of the categories.
class ProductPageCategoryStylingConfiguration {
  /// Constructor to create a new instance of
  /// [ProductPageCategoryStylingConfiguration].
  const ProductPageCategoryStylingConfiguration({
    this.headerStyling,
    this.headerCentered = false,
    this.customTitle,
    this.title,
    this.titleStyle,
    this.titleCentered = false,
    this.isCategoryCollapsible = true,
  });

  /// Optional title for the category list. This will be displayed at the
  /// top of the list.
  final String? title;

  /// Optional custom title widget for the category list. This will be
  /// displayed at the top of the list. If set, the text title will be
  /// ignored.
  final Widget? customTitle;

  /// Optional title style for the title of the category list. This will
  /// be applied to the title of the category list. If not set, the default
  /// text style will be used.
  final TextStyle? titleStyle;

  /// Configure if the title should be centered.
  ///
  /// Default is false.
  final bool titleCentered;

  /// Optional header styling for the categories. This will be applied to
  /// the name of the categories. If not set, the default text style will
  /// be used.
  final CategoryHeaderStyling? headerStyling;

  /// Configure if the category header should be centered.
  ///
  /// Default is false.
  final bool headerCentered;

  /// Configure if the category should be collapsible.
  ///
  /// Default is true.
  final bool isCategoryCollapsible;
}
