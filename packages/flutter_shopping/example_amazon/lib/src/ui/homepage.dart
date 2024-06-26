import "package:flutter/material.dart";
import "package:flutter_shopping/flutter_shopping.dart";
import "package:go_router/go_router.dart";

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Badge(
            label: const Text("1"),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, size: 50),
              onPressed: () => context.go(FlutterShoppingPathRoutes.shop),
            ),
          ),
        ),
      );
}
