import "package:flutter/material.dart";
import "package:flutter_shopping/main.dart";

/// Default order failed widget.
class DefaultOrderFailed extends StatelessWidget {
  /// Constructor for the DefaultOrderFailed.
  const DefaultOrderFailed({
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
        child: Text("Go back".toUpperCase()),
      ),
    );

    var content = Column(
      children: [
        const Spacer(),
        const Icon(
          Icons.error,
          size: 100,
          color: Colors.red,
        ),
        const SizedBox(height: 16),
        Text(
          "Uh oh.",
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 32),
        Text(
          "It seems that something went wrong.",
          style: theme.textTheme.bodyMedium,
        ),
        Text(
          "Please try again later.",
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
