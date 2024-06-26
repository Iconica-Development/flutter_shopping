import "package:example/config/order_detail_screen_configuration.dart";
import "package:example/utils/theme.dart";
import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  ///
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: "Flutter Demo",
        theme: getTheme(),
        home: OrderDetailScreen(
          configuration: getOrderDetailConfiguration(),
        ),
      );
}
