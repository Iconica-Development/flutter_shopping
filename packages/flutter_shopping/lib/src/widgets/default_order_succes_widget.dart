import "package:flutter/material.dart";
import "../../flutter_shopping.dart";

/// Default order success widget.
class DefaultOrderSucces extends StatelessWidget {
  /// Constructor for the DefaultOrderSucces.
  const DefaultOrderSucces({
    required this.configuration,
    super.key,
  });

  /// Configuration for the user-story.
  final FlutterShoppingConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var finishOrderButton = FilledButton(
      onPressed: () => configuration.onCompleteUserStory(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 32.0,
          vertical: 8.0,
        ),
        child: Text("Finish Order".toUpperCase()),
      ),
    );

    var content = Column(
      children: [
        const Spacer(),
        Text("#123456", style: theme.textTheme.titleLarge),
        const SizedBox(height: 16),
        Text(
          "Order Succesfully Placed!",
          style: theme.textTheme.titleLarge,
        ),
        Text(
          "Thank you for your order!",
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          "Your order will be delivered soon.",
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        Text(
          "Do you want to order again?",
          style: theme.textTheme.bodyMedium,
        ),
        const Spacer(),
        finishOrderButton,
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: content,
        ),
      ),
    );
  }
}
