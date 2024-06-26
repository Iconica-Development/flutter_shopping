/// OrderResult model.
/// When an user completes the field and presses the complete button,
/// the `onComplete` method returns an instance of this class that contains
/// all the developer-specified `outputKey`s and the value that was provided
/// by the user.
class OrderResult {
  /// Constructor of the order result class.
  OrderResult({
    required this.order,
  });

  /// Map of `outputKey`s and their respected values.
  final Map<String, dynamic> order;
}
