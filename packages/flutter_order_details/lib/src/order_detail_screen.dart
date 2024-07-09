import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";
import "package:flutter_order_details/src/widgets/default_appbar.dart";
import "package:flutter_order_details/src/widgets/default_next_button.dart";
import "package:flutter_order_details/src/widgets/default_order_detail_pages.dart";

/// Order Detail Screen.
class OrderDetailScreen extends StatefulWidget {
  /// Screen that builds all forms based on the configuration.
  const OrderDetailScreen({
    required this.configuration,
    super.key,
  });

  /// Configuration for the screen.
  final OrderDetailConfiguration configuration;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = FlutterFormController();
    return Scaffold(
      appBar: widget.configuration.appBarBuilder?.call(
            context,
            widget.configuration.translations.orderDetailsTitle,
          ) ??
          DefaultAppbar(
            title: widget.configuration.translations.orderDetailsTitle,
          ),
      body: FlutterForm(
        formController: controller,
        options: FlutterFormOptions(
          nextButton: (pageNumber, checkingPages) =>
              widget.configuration.nextbuttonBuilder?.call(
                pageNumber,
                checkingPages,
                context,
                widget.configuration,
                controller,
              ) ??
              DefaultNextButton(
                controller: controller,
                configuration: widget.configuration,
                currentStep: pageNumber,
                checkingPages: checkingPages,
              ),
          pages: widget.configuration.pages?.call(context) ??
              defaultPages(context, () {
                setState(() {});
              }),
          onFinished: (data) async {
            widget.configuration.onStepsCompleted.call(
              widget.configuration.shoppingService.shopService.selectedShop!.id,
              widget.configuration.shoppingService.shoppingCartService.products,
              data,
              widget.configuration,
            );
          },
          onNext: (step, data) {},
        ),
      ),
    );
  }
}
