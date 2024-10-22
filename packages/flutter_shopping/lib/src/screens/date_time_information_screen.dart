import "package:animated_toggle/animated_toggle.dart";
import "package:flutter/material.dart";
import "package:flutter_form_wizard/flutter_form.dart";
import "package:flutter_shopping/flutter_shopping.dart";

/// The morning times.
List<String> morningTimes = <String>[
  "09:00",
  "09:15",
  "09:30",
  "09:45",
  "10:00",
  "10:15",
  "10:30",
  "10:45",
  "11:00",
  "11:15",
  "11:30",
  "11:45",
];

/// The afternoon times.
List<String> afternoonTimes = <String>[
  "12:00",
  "12:15",
  "12:30",
  "12:45",
  "13:00",
  "13:15",
  "13:30",
  "13:45",
  "14:00",
  "14:15",
  "14:30",
  "14:45",
  "15:00",
  "15:15",
  "15:30",
  "15:45",
  "16:00",
  "16:15",
  "16:30",
  "16:45",
  "17:00",
];

/// The personal information page.
class DateTimeInformationScreen extends StatefulWidget {
  /// Constructor for the PersonalInformationScreen.
  const DateTimeInformationScreen({
    required this.translations,
    required this.onFinished,
    super.key,
  });

  /// The translations.
  final ShoppingTranslations translations;

  /// The on finished function.
  final Function(Map<String, dynamic>) onFinished;

  @override
  State<DateTimeInformationScreen> createState() =>
      _DateTimeInformationScreenState();
}

class _DateTimeInformationScreenState extends State<DateTimeInformationScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var dateTimeInformationController = FlutterFormController();
    var multipleChoiceController = FlutterFormInputMultipleChoiceController(
      id: "multipleChoice",
      mandatory: true,
    );
    InputDecoration dropdownInputDecoration(String hint) => InputDecoration(
          hintStyle: theme.textTheme.bodySmall,
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        );

    var switchStatus = ValueNotifier(false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.translations.dateTimeInformationTitle),
      ),
      body: FlutterForm(
        formController: dateTimeInformationController,
        options: FlutterFormOptions(
          pages: [
            FlutterFormPage(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        widget.translations.chooseDateAndTime,
                        style: theme.textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    FlutterFormInputDropdown(
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black,
                      ),
                      isDense: true,
                      decoration: dropdownInputDecoration(
                        widget.translations.selectDay,
                      ),
                      validationMessage: widget.translations.selectDayError,
                      controller: FlutterFormInputDropdownController(
                        id: "date",
                        mandatory: true,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: widget.translations.dayToday,
                          child: Text(
                            widget.translations.dayToday,
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                        DropdownMenuItem(
                          value: widget.translations.dayTomorrow,
                          child: Text(
                            widget.translations.dayTomorrow,
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ValueListenableBuilder(
                        valueListenable: switchStatus,
                        builder: (context, value, child) => AnimatedToggle(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color:
                                    theme.colorScheme.primary.withOpacity(0.8),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          width: 280,
                          toggleColor: theme.colorScheme.primary,
                          onSwitch: (value) {
                            switchStatus.value = !switchStatus.value;
                          },
                          childLeft: Center(
                            child: Text(
                              widget.translations.morning,
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: switchStatus.value
                                    ? theme.colorScheme.primary
                                    : Colors.white,
                              ),
                            ),
                          ),
                          childRight: Center(
                            child: Text(
                              widget.translations.afternoon,
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: switchStatus.value
                                    ? Colors.white
                                    : theme.colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ValueListenableBuilder(
                      valueListenable: switchStatus,
                      builder: (context, value, child) =>
                          FlutterFormInputMultipleChoice(
                        validationMessage: widget.translations.selectTime,
                        controller: multipleChoiceController,
                        options:
                            switchStatus.value ? afternoonTimes : morningTimes,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        childAspectRatio: 2,
                        height: MediaQuery.of(context).size.height * 0.6,
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
                            ),
                            height: 40,
                            child: Center(
                              child: Text(options[index]),
                            ),
                          ),
                        ),
                      ),
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
                text: widget.translations.personalInformationButton,
                onPressed: () async {
                  await dateTimeInformationController.autoNextStep();
                },
              ),
            ),
          ),
          onFinished: (values) {
            widget.onFinished(values.entries.first.value);
          },
          onNext: (page, values) {},
        ),
      ),
    );
  }
}
