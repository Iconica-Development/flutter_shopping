import "package:flutter/material.dart";
import "package:flutter_product_page/flutter_product_page.dart";

/// SpacedWrap is a widget that wraps a list of items that are spaced out and
/// fill the available width.
class SpacedWrap extends StatelessWidget {
  /// Creates a [SpacedWrap].
  const SpacedWrap({
    required this.shops,
    required this.onTap,
    required this.width,
    this.paddingBetweenButtons = 2.0,
    this.paddingOnButtons = 4.0,
    this.selectedItem = "",
    super.key,
  });

  /// List of items.
  final List<ProductPageShop> shops;

  /// Selected item.
  final String selectedItem;

  /// Width of the widget.
  final double width;

  /// Padding between the buttons.
  final double paddingBetweenButtons;

  /// Padding on the buttons.
  final double paddingOnButtons;

  /// Callback when an item is tapped.
  final Function(ProductPageShop shop) onTap;

  Row _buildRow(
    BuildContext context,
    List<int> currentRow,
    double availableRowLength,
  ) {
    var theme = Theme.of(context);

    var row = <Widget>[];
    var extraButtonPadding = availableRowLength / currentRow.length / 2;

    for (var i = 0, len = currentRow.length; i < len; i++) {
      var shop = shops[currentRow[i]];
      row.add(
        Padding(
          padding: EdgeInsets.only(top: paddingBetweenButtons),
          child: InkWell(
            onTap: () => onTap(shop),
            child: Container(
              decoration: BoxDecoration(
                color: shop.id == selectedItem
                    ? theme.colorScheme.primary
                    : theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 1,
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: paddingOnButtons + extraButtonPadding,
                vertical: paddingOnButtons,
              ),
              child: Text(
                shop.name,
                style: shop.id == selectedItem
                    ? theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )
                    : theme.textTheme.bodyMedium,
              ),
            ),
          ),
        ),
      );
      if (shops.last != shop) {
        row.add(const Spacer());
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: row,
    );
  }

  List<Row> _buildButtonRows(BuildContext context) {
    var theme = Theme.of(context);
    var rows = <Row>[];
    var currentRow = <int>[];
    var availableRowLength = width;

    for (var i = 0; i < shops.length; i++) {
      var shop = shops[i];

      var textPainter = TextPainter(
        text: TextSpan(
          text: shop.name,
          style: shop.id == selectedItem
              ? theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )
              : theme.textTheme.bodyMedium,
        ),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      )..layout(minWidth: 0, maxWidth: double.infinity);

      var buttonWidth = textPainter.width + paddingOnButtons * 2;

      if (availableRowLength - buttonWidth < 0) {
        rows.add(
          _buildRow(
            context,
            currentRow,
            availableRowLength,
          ),
        );
        currentRow = <int>[];
        availableRowLength = width;
      }

      currentRow.add(i);

      availableRowLength -= buttonWidth + paddingBetweenButtons;
    }
    if (currentRow.isNotEmpty) {
      rows.add(
        _buildRow(
          context,
          currentRow,
          availableRowLength,
        ),
      );
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) => Column(
        children: _buildButtonRows(
          context,
        ),
      );
}
