import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";


/// Default next button for the order details page.
class DefaultNextButton extends StatelessWidget {
  /// Constructor for the default next button for the order details page.
  const DefaultNextButton({
    required this.controller,
    required this.configuration,
    required this.currentStep,
    required this.checkingPages,
    super.key,
  });

  /// Configuration for the order details page.
  final OrderDetailConfiguration configuration;
  /// Controller for the form.
  final FlutterFormController controller;
  /// Current step in the form.
  final int currentStep;
  /// Whether the form is checking pages.
  final bool checkingPages;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var nextButtonTexts = [
      "Choose date and time",
      "Next",
      "Next",
    ];

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 32),
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () async {
              configuration.onNextStep(
                currentStep,
                controller.getCurrentStepResults(),
                controller,
              );
            },
            style: theme.filledButtonTheme.style?.copyWith(
              backgroundColor: WidgetStateProperty.all(
                theme.colorScheme.primary,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12,
              ),
              child: Text(
                nextButtonTexts[currentStep],
                style: theme.textTheme.displayLarge,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
