import "package:amazon/src/routes.dart";
import "package:amazon/src/utils/theme.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        restorationScopeId: "app",
        theme: getTheme(),
        routerConfig: ref.read(routerProvider),
      );
}
