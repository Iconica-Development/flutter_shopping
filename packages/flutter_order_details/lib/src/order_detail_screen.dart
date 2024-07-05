import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";

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
      appBar: widget.configuration.appBar!.call(
        context,
        widget.configuration.translations!.orderDetailsTitle,
      ),
      body: FlutterForm(
        formController: controller,
        options: FlutterFormOptions(
          nextButton: (pageNumber, checkingPages) =>
              widget.configuration.nextbuttonBuilder!(
            pageNumber,
            checkingPages,
            context,
            widget.configuration,
            controller,
          ),
          pages: widget.configuration.pages!.call(context),
          onFinished: (data) async {
            widget.configuration.onStepsCompleted.call(
              widget.configuration.shoppingService.shopService.selectedShop!.id,
              widget.configuration.shoppingService.shoppingCartService.products,
              data,
              widget.configuration,
            );
          },
          onNext: (step, data) {
            
          },
        ),
      ),
    );
  }
}
