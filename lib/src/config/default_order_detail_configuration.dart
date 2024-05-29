import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";
import "package:flutter_shopping/flutter_shopping.dart";
import "package:go_router/go_router.dart";

/// Default order detail configuration for the app.
/// This configuration is used to create the order detail page.
OrderDetailConfiguration getDefaultOrderDetailConfiguration(
  BuildContext context,
  FlutterShoppingConfiguration configuration,
) =>
    OrderDetailConfiguration(
      steps: [
        OrderDetailStep(
          formKey: GlobalKey<FormState>(),
          stepName: "Basic Information",
          fields: [
            OrderTextInput(
              title: "First name",
              outputKey: "first_name",
              textController: TextEditingController(),
            ),
            OrderTextInput(
              title: "Last name",
              outputKey: "last_name",
              textController: TextEditingController(),
            ),
            OrderEmailInput(
              title: "Your email address",
              outputKey: "email",
              textController: TextEditingController(),
              subtitle: "* We will send your order confirmation here",
              hint: "your_email@mail.com",
            ),
          ],
        ),
        OrderDetailStep(
          formKey: GlobalKey<FormState>(),
          stepName: "Address Information",
          fields: [
            OrderAddressInput(
              title: "Your address",
              outputKey: "address",
              textController: TextEditingController(),
            ),
          ],
        ),
        OrderDetailStep(
          formKey: GlobalKey<FormState>(),
          stepName: "Payment Information",
          fields: [
            OrderChoiceInput(
              title: "Payment option",
              outputKey: "payment_option",
              items: ["Pay now", "Pay later"],
            ),
          ],
        ),
      ],
      onCompleted: (OrderResult result) async =>
          onCompleteOrderDetails(context, configuration, result),
      appBar: AppBar(
        title: const Text("Order Details"),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.go(FlutterShoppingPathRoutes.shoppingCart),
        ),
      ),
    );
