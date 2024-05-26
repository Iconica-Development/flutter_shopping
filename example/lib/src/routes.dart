import "package:example/src/configuration/configuration.dart";
import "package:example/src/ui/homepage.dart";
import "package:example/src/utils/go_router.dart";
import "package:flutter_shopping/main.dart";
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
