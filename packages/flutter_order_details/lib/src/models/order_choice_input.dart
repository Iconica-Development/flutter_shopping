import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";
import "package:flutter_order_details/src/models/formfield_error_builder.dart";

/// Order input for choice with predefined text fields and validation.
class OrderChoiceInput extends OrderDetailInput<String> {
  /// Constructor of the order choice input.
  OrderChoiceInput({
    required super.title,
    required super.outputKey,
    required this.items,
    super.titleStyle,
    super.titleAlignment,
    super.titlePadding,
    super.subtitle,
    super.errorIsRequired,
    super.isRequired,
    super.isReadOnly,
    super.initialValue,
    this.fieldHeight = 140,
    this.fieldPadding = const EdgeInsets.symmetric(
      horizontal: 4,
      vertical: 64,
    ),
    this.paddingBetweenFields = const EdgeInsets.symmetric(vertical: 12),
  });

  /// Items to show within the dropdown menu.
  final List<String> items;

  /// Padding for the field.
  final EdgeInsets fieldPadding;

  /// Padding between fields.
  @override
  // ignore: overridden_fields
  final EdgeInsets paddingBetweenFields;

  /// The height of the input field.
  final double fieldHeight;

  final _ChoiceNotifier _notifier = _ChoiceNotifier();

  @override
  Widget build(
    BuildContext context,
    String? buildInitialValue,
    Function({bool needsBlur}) onBlurBackground,
  ) {
    void onItemChanged(String value) {
      if (value == currentValue) {
        currentValue = null;
        onValueChanged?.call("");
        _notifier.setValue("");
      } else {
        currentValue = value;
        onValueChanged?.call(value);
        _notifier.setValue(value);
      }
    }

    return buildOutline(
      context,
      ListenableBuilder(
        listenable: _notifier,
        builder: (context, child) => _ChoiceInputField(
          currentValue: currentValue ?? initialValue ?? buildInitialValue ?? "",
          items: items,
          onTap: onItemChanged,
          validate: validate,
          fieldPadding: fieldPadding,
          paddingBetweenFields: paddingBetweenFields,
        ),
      ),
      onBlurBackground,
    );
  }
}

class _ChoiceNotifier extends ChangeNotifier {
  String? _value;

  String? get value => _value;

  void setValue(String value) {
    _value = value;
    notifyListeners();
  }
}

class _ChoiceInputField<T> extends FormField<T> {
  _ChoiceInputField({
    required T currentValue,
    required List<T> items,
    required Function(T) onTap,
    required String? Function(T?) validate,
    required EdgeInsets fieldPadding,
    required EdgeInsets paddingBetweenFields,
    super.key,
  }) : super(
          validator: (value) => validate(currentValue),
          builder: (FormFieldState<T> field) => Padding(
            padding: fieldPadding,
            child: Column(
              children: [
                for (var item in items) ...[
                  Padding(
                    padding: paddingBetweenFields,
                    child: _InputContent<T>(
                      i: item,
                      currentValue: currentValue,
                      onTap: onTap,
                    ),
                  ),
                ],
                if (field.hasError) ...[
                  FormFieldErrorBuilder(errorMessage: field.errorText!),
                ],
              ],
            ),
          ),
        );
}

class _InputContent<T> extends StatelessWidget {
  const _InputContent({
    required this.i,
    required this.currentValue,
    required this.onTap,
  });

  final T i;
  final T currentValue;
  final Function(T) onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var boxDecoration = BoxDecoration(
      color: currentValue == i.toString()
          ? theme.colorScheme.primary
          : theme.colorScheme.secondary,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: theme.colorScheme.primary,
        width: 1,
      ),
    );

    var decoratedBox = Container(
      decoration: boxDecoration,
      width: double.infinity,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            i.toString(),
            style: theme.textTheme.labelLarge?.copyWith(
              color: currentValue == i.toString()
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTap: () => onTap(i),
      child: decoratedBox,
    );
  }
}
