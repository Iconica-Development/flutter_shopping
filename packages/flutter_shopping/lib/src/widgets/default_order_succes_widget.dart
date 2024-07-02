import "package:flutter/material.dart";
import "package:flutter_shopping/flutter_shopping.dart";

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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirmation",
          style: theme.textTheme.headlineLarge,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 32,
                top: 32,
                right: 32,
              ),
              child: Column(
                children: [
                  Text(
                    "Success!",
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Thank you Peter for your order!",
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "The order was placed at Bakkerij de Goudkorst."
                    " You can pick this"
                    " up on Monday, February 7 at 1:00 PM.",
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    "If you want, you can place another order in this street.",
                    style: theme.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    "Weekly offers",
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 272,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 32),
                  _discount(context),
                  const SizedBox(width: 8),
                  _discount(context),
                  const SizedBox(width: 32),
                ],
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {
                configuration.onCompleteUserStory.call(context);
              },
              child: Text(
                "Place another order",
                style: theme.textTheme.displayLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _discount(BuildContext context) {
  var theme = Theme.of(context);
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.black,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    width: MediaQuery.of(context).size.width - 64,
    height: 200,
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          child: Image.network(
            "https://picsum.photos/150",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 38,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Butcher Puurvlees",
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width,
            height: 68,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Chicken legs, now for 4,99",
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
