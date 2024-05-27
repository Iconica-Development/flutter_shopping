import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";
import "package:flutter_shopping/main.dart";
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
              // hint: ""
            ),
          ],
        ),
        OrderDetailStep(
          formKey: GlobalKey<FormState>(),
          stepName: "Adress Information",
          fields: [
            OrderAdresInput(
              title: "Your adress",
              outputKey: "adres",
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
      onCompleted: (OrderResult result) async {
        await onCompleteOrderDetails(context, configuration, result);
      },
      appBar: AppBar(
        title: const Text("Order Details"),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.go(FlutterShoppingRoutes.shoppingCart),
        ),
      ),
    );
