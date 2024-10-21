/// Translations for the Shopping package.
class ShoppingTranslations {
  /// Constructor for the Shopping translations.
  const ShoppingTranslations({
    /// screen titles
    this.filterTitle = "filter",
    this.shoppingCartTitle = "Shopping cart",
    this.personalInformationTitle = "information",
    this.dateTimeInformationTitle = "information",
    this.paymentOptionsTitle = "information",

    /// button text
    this.orderButton = "Order",
    this.closeInfo = "Close",
    this.viewShoppingCart = "View shopping cart",
    this.personalInformationButton = "Choose date and time",
    this.paymentButton = "Next",
    this.datetimeInformationButton = "Next",

    /// body text
    this.weeklyOffer = "Weekly offer",
    this.whatWouldyouLikeToOrder = "What would you like to order?",
    this.shoppingCartProducts = "Products",
    this.shoppingCartTotal = "Subtotal",
    this.shoppingCartCurrency = "€",
    this.personalInformationName = "What’s your name?",
    this.personalInformationAddress = "What’s your address?",
    this.personalInformationPhone = "What’s your phone number?",
    this.personalInformationEmail = "What’s your email address?",
    this.personalInformationComment = "Do you have any comments?",
    this.paymenttitle = "Payment method",
    this.paymentExplainer =
        "Choose when you would like to to pay for the order.",
    this.payNow = "Pay now",
    this.payLater = "Pay later",
    this.chooseDateAndTime =
        "When and at what time would you like to pick up your order?",
    this.selectDay = "Select a day",
    this.dayToday = "Today",
    this.dayTomorrow = "Tomorrow",
    this.morning = "Morning",
    this.afternoon = "Afternoon",
    this.selectTime = "Select a time",

    /// error messages
    this.nameRequired = "Name is required",
    this.addressRequired = "Please enter a street and house number",
    this.postalCodeRequired = "Please enter your postal code",
    this.cityRequired = "Please enter your city",
    this.phoneRequired = "Please enter your phone number",
    this.emailRequired = "Email is required",
    this.invalidEmail = "Please fill in a valid email address",
    this.paymentError = "Please select a payment method",
    this.invalidAdress = "Invalid street and house number",
    this.invalidPostalCode = "Invalid postal code",
    this.invalidPhoneLength = "Invalid phone number length",
    this.phoneContainsLettersError = "Phone number can only contain digits",
    this.selectDayError = "Please select a day",

    /// hint text
    this.nameHint = "full name",
    this.addressHint = "street name and number",
    this.postalCodeHint = "postal code",
    this.cityHint = "city",
    this.phoneHint = "phone number",
    this.emailHint = "email address",
    this.commentHint = "optional",
  });

  /// Appbar title for filter screen.
  final String filterTitle;

  /// Appbar title for shopping cart screen.
  final String shoppingCartTitle;

  /// Appbar title for personal information screen.
  final String personalInformationTitle;

  /// Text for the order button.
  final String orderButton;

  /// Text for the close info button.
  final String closeInfo;

  /// Text for the view shopping cart button.
  final String viewShoppingCart;

  /// Text for the personal information button.
  final String personalInformationButton;

  /// Text for the weekly offer.
  final String weeklyOffer;

  /// Text for the question what would you like to order.
  final String whatWouldyouLikeToOrder;

  /// Text for the products.
  final String shoppingCartProducts;

  /// Text for the total price in the shopping cart.
  final String shoppingCartTotal;

  /// The currency that is being used
  final String shoppingCartCurrency;

  /// Text for the personal information fields.
  final String personalInformationName;

  /// Text for the personal information fields.
  final String personalInformationAddress;

  /// Text for the personal information fields.
  final String personalInformationPhone;

  /// Text for the personal information fields.
  final String personalInformationEmail;

  /// Text for the personal information fields.
  final String personalInformationComment;

  /// Text for the name required field.
  final String nameRequired;

  /// Text for the address field.
  final String addressRequired;

  /// Text for the postal code field.
  final String postalCodeRequired;

  /// Text for the city field.
  final String cityRequired;

  /// Text for the phone field.
  final String phoneRequired;

  /// Text for the email field.
  final String emailRequired;

  /// Text for the invalid email field.
  final String invalidEmail;

  /// Text for the name hint.
  final String nameHint;

  /// Text for the address hint.
  final String addressHint;

  /// Text for the postal code hint.
  final String postalCodeHint;

  /// Text for the city hint.
  final String cityHint;

  /// Text for the phone hint.
  final String phoneHint;

  /// Text for the email hint.
  final String emailHint;

  /// Text for the comment hint.
  final String commentHint;

  /// Text for the date and time information title.
  final String dateTimeInformationTitle;

  /// Text for the payment options title.
  final String paymentOptionsTitle;

  /// Text for the payment error.
  final String paymentError;

  /// Text for the payment title.
  final String paymenttitle;

  /// Text for the payment explainer.
  final String paymentExplainer;

  /// Text for the pay now button.
  final String payNow;

  /// Text for the pay later button.
  final String payLater;

  /// Text for the payment button.
  final String paymentButton;

  /// Text for the invalid address.
  final String invalidAdress;

  /// Text for the invalid postal code.
  final String invalidPostalCode;

  /// Text for the invalid phone length.
  final String invalidPhoneLength;

  /// Text for the phone contains letters error.
  final String phoneContainsLettersError;

  /// Text for the select day error.
  final String datetimeInformationButton;

  /// Text for the choose date and time.
  final String chooseDateAndTime;

  /// Text for the select day.
  final String selectDay;

  /// Text for the select day error.
  final String selectDayError;

  /// Text for the day today.
  final String dayToday;

  /// Text for the day tomorrow.
  final String dayTomorrow;

  /// Text for the morning.
  final String morning;

  /// Text for the afternoon.
  final String afternoon;

  /// Text for the select time.
  final String selectTime;
}
