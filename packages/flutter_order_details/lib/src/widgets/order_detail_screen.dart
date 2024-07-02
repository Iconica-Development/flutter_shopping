import "package:flutter/material.dart";
import "package:flutter_form_wizard/flutter_form.dart";
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
      appBar: widget.configuration.appBar
          .call(context, widget.configuration.localization),
      body: FlutterForm(
        formController: controller,
        options: FlutterFormOptions(
          nextButton: (a, b) => widget.configuration.nextbuttonBuilder(
            a,
            b,
            context,
            widget.configuration,
            controller,
          ),
          pages: widget.configuration.pages.call(context),
          onFinished: (data) {
            widget.configuration.onCompleted.call(data);
          },
          onNext: (step, data) {},
        ),
      ),
    );
  }
}
