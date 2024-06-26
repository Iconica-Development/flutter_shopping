import "package:flutter_shopping/flutter_shopping.dart";
import "package:flutter_shopping/src/config/default_order_detail_configuration.dart";
import "package:flutter_shopping/src/widgets/default_order_failed_widget.dart";
import "package:flutter_shopping/src/widgets/default_order_succes_widget.dart";
import "package:go_router/go_router.dart";

/// All the routes for the shopping story.
List<GoRoute> getShoppingStoryRoutes({
  required FlutterShoppingConfiguration configuration,
}) =>
    <GoRoute>[
      GoRoute(
        name: FlutterShoppingNameRoutes.shop,
        path: FlutterShoppingPathRoutes.shop,
        builder: (context, state) => configuration.shopBuilder(
          context,
          state.uri.queryParameters["id"],
          state.uri.queryParameters["street"],
        ),
      ),
      GoRoute(
        name: FlutterShoppingNameRoutes.shoppingCart,
        path: FlutterShoppingPathRoutes.shoppingCart,
        builder: (context, state) => configuration.shoppingCartBuilder(context),
      ),
      GoRoute(
        name: FlutterShoppingNameRoutes.orderDetails,
        path: FlutterShoppingPathRoutes.orderDetails,
        builder: (context, state) => configuration.orderDetailsBuilder != null
            ? configuration.orderDetailsBuilder!(context)
            : OrderDetailScreen(
                configuration:
                    getDefaultOrderDetailConfiguration(context, configuration),
              ),
      ),
      GoRoute(
        name: FlutterShoppingNameRoutes.orderSuccess,
        path: FlutterShoppingPathRoutes.orderSuccess,
        builder: (context, state) => configuration.orderSuccessBuilder != null
            ? configuration.orderSuccessBuilder!(context)
            : DefaultOrderSucces(configuration: configuration),
      ),
      GoRoute(
        name: FlutterShoppingNameRoutes.orderFailed,
        path: FlutterShoppingPathRoutes.orderFailed,
        builder: (context, state) => configuration.orderFailedBuilder != null
            ? configuration.orderFailedBuilder!(context)
            : DefaultOrderFailed(configuration: configuration),
      ),
    ];
