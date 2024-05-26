import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";
import "package:flutter_shopping/main.dart";
import "package:flutter_shopping/src/config/default_order_detail_configuration.dart";
import "package:flutter_shopping/src/go_router.dart";
import "package:flutter_shopping/src/widgets/default_order_failed_widget.dart";
import "package:flutter_shopping/src/widgets/default_order_succes_widget.dart";
import "package:go_router/go_router.dart";

/// TODO
List<GoRoute> getShoppingStoryRoutes({
  required FlutterShoppingConfiguration configuration,
}) =>
    <GoRoute>[
      GoRoute(
        name: "shop",
        path: FlutterShoppingRoutes.shop,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildScreenWithFadeTransition(
          context: context,
          state: state,
          child: configuration.shopBuilder(context),
        ),
      ),
      GoRoute(
        name: "shoppingCart",
        path: FlutterShoppingRoutes.shoppingCart,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            buildScreenWithFadeTransition(
          context: context,
          state: state,
          child: configuration.shoppingCartBuilder(context),
        ),
      ),
      GoRoute(
        name: "orderDetails",
        path: FlutterShoppingRoutes.orderDetails,
        pageBuilder: (BuildContext context, GoRouterState state) {
          if (configuration.showOrderDetails &&
              configuration.orderDetailsBuilder != null) {
            return buildScreenWithFadeTransition(
              context: context,
              state: state,
              child: configuration.orderDetailsBuilder!(context),
            );
          }

          return buildScreenWithFadeTransition(
            context: context,
            state: state,
            child: OrderDetailScreen(
              configuration:
                  getDefaultOrderDetailConfiguration(context, configuration),
            ),
          );
        },
      ),
      GoRoute(
        name: "orderSuccess",
        path: FlutterShoppingRoutes.orderSuccess,
        pageBuilder: (BuildContext context, GoRouterState state) {
          if (configuration.orderSuccessBuilder != null) {
            return buildScreenWithFadeTransition(
              context: context,
              state: state,
              child: configuration.orderSuccessBuilder!(context),
            );
          }

          return buildScreenWithFadeTransition(
            context: context,
            state: state,
            child: DefaultOrderSucces(configuration: configuration),
          );
        },
      ),
      GoRoute(
        name: "orderFailed",
        path: FlutterShoppingRoutes.orderFailed,
        pageBuilder: (BuildContext context, GoRouterState state) {
          if (configuration.orderFailedBuilder != null) {
            return buildScreenWithFadeTransition(
              context: context,
              state: state,
              child: configuration.orderFailedBuilder!(context),
            );
          }

          return buildScreenWithFadeTransition(
            context: context,
            state: state,
            child: DefaultOrderFailed(
              configuration: configuration,
            ),
          );
        },
      ),
    ];
