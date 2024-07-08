import "package:animated_toggle/animated_toggle.dart";
import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";


/// Default pages for the order details screen.
List<FlutterFormPage> defaultPages(BuildContext context) {
  var theme = Theme.of(context);

  var morningTimes = <String>[
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

  var afternoonTimes = <String>[
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
  var switchStatus = ValueNotifier<bool>(false);
  var multipleChoiceController = FlutterFormInputMultipleChoiceController(
    id: "multipleChoice",
    mandatory: true,
  );
  return [
    FlutterFormPage(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "What's your name?",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              FlutterFormInputPlainText(
                decoration: inputDecoration("Name"),
                style: theme.textTheme.bodySmall,
                controller: FlutterFormInputPlainTextController(
                  id: "name",
                  mandatory: true,
                ),
                validationMessage: "Please enter your name",
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "What's your address?",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              FlutterFormInputPlainText(
                decoration: inputDecoration("Street and number"),
                style: theme.textTheme.bodySmall,
                controller: FlutterFormInputPlainTextController(
                  id: "street",
                  mandatory: true,
                ),
                validationMessage: "Please enter your address",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a street and house number";
                  }
                  var regex = RegExp(r"^[A-Za-z]+\s[0-9]{1,3}$");
                  if (!regex.hasMatch(value)) {
                    return "Invalid street and house number";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 4,
              ),
              FlutterFormInputPlainText(
                decoration: inputDecoration("Postal code"),
                style: theme.textTheme.bodySmall,
                controller: FlutterFormInputPlainTextController(
                  id: "postalCode",
                  mandatory: true,
                ),
                validationMessage: "Please enter your postal code",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a postal code";
                  }
                  var regex = RegExp(r"^[0-9]{4}[A-Za-z]{2}$");
                  if (!regex.hasMatch(value)) {
                    return "Invalid postal code format";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 4,
              ),
              FlutterFormInputPlainText(
                decoration: inputDecoration("City"),
                style: theme.textTheme.bodySmall,
                controller: FlutterFormInputPlainTextController(
                  id: "city",
                  mandatory: true,
                ),
                validationMessage: "Please enter your city",
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "What's your phone number?",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              FlutterFormInputPhone(
                numberFieldStyle: theme.textTheme.bodySmall,
                textAlignVertical: TextAlignVertical.center,
                decoration: inputDecoration("Phone number"),
                controller: FlutterFormInputPhoneController(
                  id: "phone",
                  mandatory: true,
                ),
                validationMessage: "Please enter your phone number",
                validator: (value) {
                  if (value == null || value.number!.isEmpty) {
                    return "Please enter a phone number";
                  }

                  // Remove any spaces or hyphens from the input
                  var phoneNumber =
                      value.number!.replaceAll(RegExp(r"\s+|-"), "");

                  // Check the length of the remaining digits
                  if (phoneNumber.length != 10 && phoneNumber.length != 11) {
                    return "Invalid phone number length";
                  }

                  // Check if all remaining characters are digits
                  if (!phoneNumber.substring(1).contains(RegExp(r"^[0-9]*$"))) {
                    return "Phone number can only contain digits";
                  }

                  // If all checks pass, return null (no error)
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "What's your email address?",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              FlutterFormInputEmail(
                style: theme.textTheme.bodySmall,
                decoration: inputDecoration("email address"),
                controller: FlutterFormInputEmailController(
                  id: "email",
                  mandatory: true,
                ),
                validationMessage: "Please fill in a valid email address",
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Do you have any comments?",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(
                height: 4,
              ),
              FlutterFormInputPlainText(
                decoration: inputDecoration("Optional"),
                style: theme.textTheme.bodySmall,
                controller: FlutterFormInputPlainTextController(
                  id: "comments",
                ),
                validationMessage: "Please enter your email address",
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    ),
    FlutterFormPage(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "When and at what time would you like to pick up your order?",
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
              decoration: dropdownInputDecoration("Select a day"),
              validationMessage: "Please select a day",
              controller: FlutterFormInputDropdownController(
                id: "date",
                mandatory: true,
              ),
              items: [
                DropdownMenuItem(
                  value: "Today",
                  child: Text(
                    "Today",
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                DropdownMenuItem(
                  value: "Tomorrow",
                  child: Text(
                    "Tomorrow",
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: AnimatedToggle(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: theme.colorScheme.primary.withOpacity(0.8),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                width: 280,
                toggleColor: theme.colorScheme.primary,
                onSwitch: (value) {
                  switchStatus.value = value;
                },
                childLeft: Center(
                  child: ListenableBuilder(
                    listenable: switchStatus,
                    builder: (context, widget) => Text(
                      "Morning",
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: switchStatus.value
                            ? theme.colorScheme.primary
                            : Colors.white,
                      ),
                    ),
                  ),
                ),
                childRight: Center(
                  child: ListenableBuilder(
                    listenable: switchStatus,
                    builder: (context, widget) => Text(
                      "Afternoon",
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
            ListenableBuilder(
              listenable: switchStatus,
              builder: (context, widget) => FlutterFormInputMultipleChoice(
                validationMessage: "Select a Time",
                controller: multipleChoiceController,
                options: switchStatus.value ? afternoonTimes : morningTimes,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 2,
                height: MediaQuery.of(context).size.height * 0.6,
                builder:
                    (context, index, selected, controller, options, state) =>
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
    FlutterFormPage(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment method",
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "Choose when you would like to to pay for the order.",
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
              height: 420,
              controller: FlutterFormInputMultipleChoiceController(
                id: "payment",
                mandatory: true,
              ),
              options: const ["PAY NOW", "PAY AT THE CASHIER"],
              builder: (context, index, selected, controller, options, state) =>
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
              validationMessage: "Please select a payment method",
            ),
          ],
        ),
      ),
    ),
  ];
}
