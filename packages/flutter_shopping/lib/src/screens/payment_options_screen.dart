import "package:flutter/material.dart";
import "package:flutter_form_wizard/flutter_form.dart";
import "package:flutter_shopping/flutter_shopping.dart";

/// A screen for the payment options.
class PaymentOptionsScreen extends StatelessWidget {
  /// Constructor for the PaymentOptionsScreen.
  const PaymentOptionsScreen({
    required this.translations,
    required this.onFinished,
    super.key,
  });

  /// The translations.
  final ShoppingTranslations translations;

  /// The on finished function.
  final Function(Map<String, dynamic>) onFinished;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var paymentOptionsController = FlutterFormController();
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.paymentOptionsTitle),
      ),
      body: FlutterForm(
        formController: paymentOptionsController,
        options: FlutterFormOptions(
          pages: [
            FlutterFormPage(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translations.paymenttitle,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      translations.paymentExplainer,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 84,
                    ),
                    FlutterFormInputMultipleChoice(
                      crossAxisCount: 1,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 5,
                      childAspectRatio: 2,
                      height: 422,
                      controller: FlutterFormInputMultipleChoiceController(
                        id: "payment",
                        mandatory: true,
                      ),
                      options: [translations.payNow, translations.payLater],
                      builder: (
                        context,
                        index,
                        selected,
                        controller,
                        options,
                        state,
                      ) =>
                          GestureDetector(
                        onTap: () {
                          state.didChange(options[index]);
                          selected.value = index;
                          controller.onSaved(options[index]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selected.value == index
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          height: 40,
                          child: Center(child: Text(options[index])),
                        ),
                      ),
                      validationMessage: translations.paymentError,
                    ),
                  ],
                ),
              ),
            ),
          ],
          nextButton: (pageNumber, checkingPages) => Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: PrimaryButton(
                text: translations.paymentButton,
                onPressed: () async {
                  await paymentOptionsController.autoNextStep();
                },
              ),
            ),
          ),
          onFinished: (values) {
            onFinished(values.entries.first.value);
          },
          onNext: (page, values) {},
        ),
      ),
    );
  }
}
