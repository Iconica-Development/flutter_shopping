import "package:amazon/src/configuration/shopping_configuration.dart";
import "package:amazon/src/ui/homepage.dart";
import "package:amazon/src/utils/go_router.dart";
import "package:flutter_shopping/flutter_shopping.dart";
import "package:go_router/go_router.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

const String homePage = "/";

final routerProvider = Provider<GoRouter>(
  (ref) => GoRouter(
    initialLocation: homePage,
    routes: [
      // Flutter Shopping Story Routes
      ...getShoppingStoryRoutes(
        configuration: getFlutterShoppingConfiguration(),
      ),

      // Home Route
      GoRoute(
        name: "home",
        path: homePage,
        pageBuilder: (context, state) => buildScreenWithFadeTransition(
          context: context,
          state: state,
          child: const Homepage(),
        ),
      ),
    ],
  ),
);
