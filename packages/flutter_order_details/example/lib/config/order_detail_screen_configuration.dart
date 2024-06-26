import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";

OrderDetailConfiguration getOrderDetailConfiguration() =>
    OrderDetailConfiguration(
      // (REQUIRED): onComplete function that allows you to do with the
      // results as wanted.
      // ignore: avoid_print
      onCompleted: (OrderResult result) => print(result.order),

      // (REQUIRED): List of steps that the user has to go through to
      // complete the order.
      steps: [
        OrderDetailStep(
          // stepName: "Step 1",
          formKey: GlobalKey<FormState>(),
          fields: [
            OrderChoiceInput(
              // REQUIRED
              title: "Payment method",
              outputKey: "payment_method",
              items: [
                "PAY NOW",
                "PAY AT CASH REGISTER",
              ],

              // OPTIONAL
              subtitle: "Choose a payment method",
            ),
          ],
        ),
        OrderDetailStep(
          // stepName: "Step 1",
          formKey: GlobalKey<FormState>(),
          fields: [
            OrderDropdownInput<String>(
              // REQUIRED
              title: "When do you want to pick up your order?",
              outputKey: "order_pickup_time",
              items: [
                "Today",
                "Monday 7 juni",
                "Tuesday 8 juni",
                "Wednesday 9 juni",
                "Thursday 10 juni",
              ],

              // OPTIONAL
              subtitle: "Choose a date",
            ),
            OrderTimePicker(
              // REQUIRED
              title: "Choose a time",

              titleStyle: OrderDetailTitleStyle.none,
              padding: EdgeInsets.zero,
              outputKey: "chosen_time",

              // OPTIONAL
              morningLabel: "Morning",
              afternoonLabel: "Afternoon",
              eveningLabel: "Evening",

              beginTime: 9, // Opening time
              endTime: 20, // Closing time
            ),
          ],
        ),
        OrderDetailStep(
          // stepName: "Step 1",
          formKey: GlobalKey<FormState>(),
          fields: [
            OrderTextInput(
              // REQUIRED
              outputKey: "user_name",
              title: "What is your name?",
              textController: TextEditingController(),

              // OPTIONAL
              hint: "Your name",
            ),
            OrderAddressInput(
              // REQUIRED
              outputKey: "user_address",
              title: "What is your address?",
              textController: TextEditingController(),
            ),
          ],
        ),
        OrderDetailStep(
          // stepName: "Step 2",
          formKey: GlobalKey<FormState>(),
          fields: [
            OrderPhoneInput(
              // REQUIRED
              outputKey: "user_phone",
              title: "Phone",
              textController: TextEditingController(),

              // OPTIONAL
              errorIsRequired: "You must enter a phone number",
              errorMustBe11Digits: "A phone number must be 11 digits long",
              errorMustBeNumeric: "Phone number must be numeric",
              errorMustStartWith316: "Phone number must start with 316",
            ),
            OrderEmailInput(
              // REQUIRED
              outputKey: "user_email",
              title: "Email",
              textController: TextEditingController(),

              // OPTIONAL
              errorInvalidEmail: "Invalid email address",
            ),
          ],
        ),
      ],

      // (OPTIONAL) (RECOMMENDED): Custom localizations.
      localization: const OrderDetailLocalization(
        backButton: "Back",
        nextButton: "Next",
        completeButton: "Complete",
      ),

      // (OPTIONAL): Progress bar
      progressIndicator: true,

      // (OPTIONAL): Input field padding
      inputFieldPadding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 16,
      ),

      // (OPTIONAL): Title padding
      titlePadding: const EdgeInsets.only(left: 16, right: 16, top: 16),

      // (OPTIONAL): App bar
      appBar: AppBar(
        title: const Text(
          "Order Details",
        ),
      ),
    );
