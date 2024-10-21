import "package:flutter/material.dart";
import "package:flutter_form_wizard/flutter_form.dart";
import "package:flutter_shopping/flutter_shopping.dart";

/// The personal information page.
class PersonalInformationScreen extends StatelessWidget {
  /// Constructor for the PersonalInformationScreen.
  const PersonalInformationScreen({
    required this.translations,
    required this.onFinished,
    required this.options,
    super.key,
  });

  /// The translations.
  final ShoppingTranslations translations;

  /// The on finished function.
  final Function(Map<String, dynamic>) onFinished;

  /// The options.
  final FlutterShoppingOptions options;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var personalInforamtionController = FlutterFormController();

    InputDecoration inputDecoration(String hint) => InputDecoration(
          hintStyle: theme.textTheme.bodySmall,
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        );
    return Scaffold(
      appBar: AppBar(
        title: Text(translations.personalInformationTitle),
      ),
      body: FlutterForm(
        formController: personalInforamtionController,
        options: FlutterFormOptions(
          pages: [
            FlutterFormPage(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translations.personalInformationName,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    FlutterFormInputPlainText(
                      decoration: options.informationInputDecoration
                              ?.call(context, translations.nameHint) ??
                          inputDecoration(translations.nameHint),
                      style: theme.textTheme.bodySmall,
                      controller: FlutterFormInputPlainTextController(
                        id: "name",
                        mandatory: true,
                      ),
                      validationMessage: translations.nameRequired,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      translations.personalInformationAddress,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    FlutterFormInputPlainText(
                      decoration: options.informationInputDecoration
                              ?.call(context, translations.addressHint) ??
                          inputDecoration(translations.addressHint),
                      style: theme.textTheme.bodySmall,
                      controller: FlutterFormInputPlainTextController(
                        id: "street",
                        mandatory: true,
                      ),
                      validationMessage: translations.addressRequired,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return translations.addressRequired;
                        }
                        var regex = RegExp(r"^[A-Za-z]+\s[0-9]{1,3}$");
                        if (!regex.hasMatch(value)) {
                          return translations.invalidAdress;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    FlutterFormInputPlainText(
                      decoration: options.informationInputDecoration
                              ?.call(context, translations.postalCodeHint) ??
                          inputDecoration(translations.postalCodeHint),
                      style: theme.textTheme.bodySmall,
                      controller: FlutterFormInputPlainTextController(
                        id: "postalCode",
                        mandatory: true,
                      ),
                      validationMessage: translations.postalCodeRequired,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return translations.postalCodeRequired;
                        }
                        var regex = RegExp(r"^[0-9]{4}[A-Za-z]{2}$");
                        if (!regex.hasMatch(value)) {
                          return translations.invalidPostalCode;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    FlutterFormInputPlainText(
                      decoration: options.informationInputDecoration
                              ?.call(context, translations.cityHint) ??
                          inputDecoration(translations.cityHint),
                      style: theme.textTheme.bodySmall,
                      controller: FlutterFormInputPlainTextController(
                        id: "city",
                        mandatory: true,
                      ),
                      validationMessage: translations.cityRequired,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      translations.personalInformationPhone,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    FlutterFormInputPhone(
                      numberFieldStyle: theme.textTheme.bodySmall,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: options.informationInputDecoration
                              ?.call(context, translations.phoneHint) ??
                          inputDecoration(translations.phoneHint),
                      controller: FlutterFormInputPhoneController(
                        id: "phone",
                        mandatory: true,
                      ),
                      validationMessage: translations.phoneRequired,
                      validator: (value) {
                        if (value == null || value.number!.isEmpty) {
                          return translations.phoneRequired;
                        }

                        // Remove any spaces or hyphens from the input
                        var phoneNumber =
                            value.number!.replaceAll(RegExp(r"\s+|-"), "");

                        // Check the length of the remaining digits
                        if (phoneNumber.length != 10 &&
                            phoneNumber.length != 11) {
                          return translations.invalidPhoneLength;
                        }

                        // Check if all remaining characters are digits
                        if (!phoneNumber
                            .substring(1)
                            .contains(RegExp(r"^[0-9]*$"))) {
                          return translations.phoneContainsLettersError;
                        }

                        // If all checks pass, return null (no error)
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      translations.personalInformationEmail,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    FlutterFormInputEmail(
                      style: theme.textTheme.bodySmall,
                      decoration: options.informationInputDecoration
                              ?.call(context, translations.emailHint) ??
                          inputDecoration(translations.emailHint),
                      controller: FlutterFormInputEmailController(
                        id: "email",
                        mandatory: true,
                      ),
                      validationMessage: translations.emailRequired,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      translations.personalInformationComment,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    FlutterFormInputPlainText(
                      decoration: options.informationInputDecoration
                              ?.call(context, translations.commentHint) ??
                          inputDecoration(translations.commentHint),
                      style: theme.textTheme.bodySmall,
                      controller: FlutterFormInputPlainTextController(
                        id: "comments",
                      ),
                      validationMessage: "",
                    ),
                    const SizedBox(
                      height: 100,
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
                text: translations.personalInformationButton,
                onPressed: () async {
                  await personalInforamtionController.autoNextStep();
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
