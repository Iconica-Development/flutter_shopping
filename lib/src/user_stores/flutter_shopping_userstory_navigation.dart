import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";
import "package:flutter_shopping/main.dart";
import "package:go_router/go_router.dart";

/// TODO
Future<void> onCompleteOrderDetails(
  BuildContext context,
  FlutterShoppingConfiguration configuration,
  OrderResult result,
) async {
  var go = context.go;
  var succesful = true;

  if (configuration.onCompleteOrderDetails != null) {
    var executionResult =
        await configuration.onCompleteOrderDetails?.call(context, result);

    if (executionResult == null || !executionResult) {
      succesful = false;
    }
  }

  if (succesful) {
    go(FlutterShoppingRoutes.orderSuccess);
  } else {
    go(FlutterShoppingRoutes.orderFailed);
  }
}

/// TODO
void onCompleteShoppingCart(
  BuildContext context,
) {
  context.go(FlutterShoppingRoutes.orderDetails);
}

/// TODO
void onCompleteProductPage(
  BuildContext context,
) {
  context.go(FlutterShoppingRoutes.shoppingCart);
}
