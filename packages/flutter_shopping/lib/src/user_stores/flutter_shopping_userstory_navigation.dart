import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";
import "../../flutter_shopping.dart";
import "package:go_router/go_router.dart";

/// Default on complete order details function.
/// This function will navigate to the order success or order failed page.
///
/// You can create your own implementation if you decide to use a different
/// approach.
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
    go(FlutterShoppingPathRoutes.orderSuccess);
  } else {
    go(FlutterShoppingPathRoutes.orderFailed);
  }
}

/// Default on complete shopping cart function.
///
/// You can create your own implementation if you decide to use a different
/// approach.
void onCompleteShoppingCart(
  BuildContext context,
) {
  context.go(FlutterShoppingPathRoutes.orderDetails);
}

/// Default on complete product page function.
///
/// You can create your own implementation if you decide to use a different
/// approach.
void onCompleteProductPage(
  BuildContext context,
) {
  context.go(FlutterShoppingPathRoutes.shoppingCart);
}
