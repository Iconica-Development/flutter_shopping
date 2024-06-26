import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";
import "package:flutter_order_details/src/models/formfield_error_builder.dart";

/// Order time picker input with predefined text fields and validation.
class OrderTimePicker extends OrderDetailInput<String> {
  /// Constructor for the time picker.
  OrderTimePicker({
    required super.title,
    required super.outputKey,
    super.titleStyle,
    super.titleAlignment,
    super.titlePadding,
    super.subtitle,
    super.isRequired,
    super.initialValue,
    super.validators,
    super.onValueChanged,
    super.errorIsRequired,
    super.hint,
    this.beginTime = 9,
    this.endTime = 17,
    this.interval = 0.25,
    this.morningLabel = "Morning",
    this.afternoonLabel = "Afternoon",
    this.eveningLabel = "Evening",
    this.padding = const EdgeInsets.only(top: 12, bottom: 20.0),
  }) : assert(
          beginTime < endTime,
          "Begin time cannot be greater than end time",
        );

  /// Minimum time of times to show. For example 9 (for 9AM).
  final double beginTime;

  /// Final time to show. For example 17 (for 5PM).
  final double endTime;

  /// For each interval a button gets generated within the begin time and
  /// the end time. For example 0.25 (for ever 15 minutes).
  final double interval;

  /// Translation for morning texts.
  final String morningLabel;

  /// Translation for afternoon texts.
  final String afternoonLabel;

  /// Translation for evening texts.
  final String eveningLabel;

  /// Padding around the time picker.
  final EdgeInsets padding;

  final _selectedTimeOfDay = _SelectedTimeOfDay();

  @override
  Widget build(
    BuildContext context,
    String? buildInitialValue,
    Function({bool needsBlur}) onBlurBackground,
  ) {
    void updateSelectedTimeOfDay(_TimeOfDay timeOfDay) {
      if (_selectedTimeOfDay.selectedTimeOfDay == timeOfDay) return;
      _selectedTimeOfDay.selectedTimeOfDay = timeOfDay;
      currentValue = null;
    }

    void updateSelectedTimeAsString(String? time) {
      currentValue = time;
      onValueChanged?.call(time ?? "");
      _selectedTimeOfDay.selectedTime = time;
    }

    void updateSelectedTime(double time) {
      if (currentValue == time.toString()) {
        updateSelectedTimeAsString(null);
      } else {
        updateSelectedTimeAsString(time.toString());
      }
    }

    if (currentValue != null) {
      var currentValueAsDouble = double.parse(currentValue!);
      for (var timeOfDay in _TimeOfDay.values) {
        if (_isTimeWithinTimeOfDay(
          currentValueAsDouble,
          currentValueAsDouble,
          timeOfDay,
        )) {
          _selectedTimeOfDay.selectedTimeOfDay = timeOfDay;
        }
      }
      updateSelectedTimeAsString(currentValue);
    } else {
      for (var timeOfDay in _TimeOfDay.values) {
        if (_isTimeWithinTimeOfDay(beginTime, endTime, timeOfDay)) {
          _selectedTimeOfDay.selectedTimeOfDay = timeOfDay;
          break;
        }
      }
    }

    return buildOutline(
      context,
      ListenableBuilder(
        listenable: _selectedTimeOfDay,
        builder: (context, _) {
          var startTime = _selectedTimeOfDay.selection != null
              ? _selectedTimeOfDay.selection!.minTime.clamp(beginTime, endTime)
              : beginTime;
          var finalTime = _selectedTimeOfDay.selection != null
              ? _selectedTimeOfDay.selection!.maxTime.clamp(beginTime, endTime)
              : endTime;

          return Column(
            children: [
              _TimeOfDaySelector(
                selectedTimeOfDay: _selectedTimeOfDay,
                updateSelectedTimeOfDay: updateSelectedTimeOfDay,
                startTime: beginTime,
                endTime: endTime,
                morningLabel: morningLabel,
                afternoonLabel: afternoonLabel,
                eveningLabel: eveningLabel,
                padding: padding,
              ),
              _TimeWrap<String>(
                currentValue: currentValue ?? "",
                startTime: startTime,
                finalTime: finalTime,
                interval: interval,
                onTap: updateSelectedTime,
                validate: super.validate,
              ),
            ],
          );
        },
      ),
      onBlurBackground,
    );
  }
}

bool _isTimeWithinTimeOfDay(
  double openingTime,
  double closingTime,
  _TimeOfDay timeOfDay,
) =>
    (timeOfDay.minTime >= openingTime && timeOfDay.minTime <= closingTime) ||
    (timeOfDay.maxTime > openingTime && timeOfDay.maxTime <= closingTime) ||
    (timeOfDay.minTime <= openingTime && timeOfDay.maxTime >= closingTime);

class _TimeOfDaySelector extends StatelessWidget {
  const _TimeOfDaySelector({
    required this.selectedTimeOfDay,
    required this.updateSelectedTimeOfDay,
    required this.startTime,
    required this.endTime,
    required this.morningLabel,
    required this.afternoonLabel,
    required this.eveningLabel,
    required this.padding,
  });

  final _SelectedTimeOfDay selectedTimeOfDay;
  final Function(_TimeOfDay) updateSelectedTimeOfDay;
  final double startTime;
  final double endTime;
  final String morningLabel;
  final String afternoonLabel;
  final String eveningLabel;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    String getLabelName(_TimeOfDay timeOfDay) => switch (timeOfDay) {
          _TimeOfDay.morning => morningLabel,
          _TimeOfDay.afternoon => afternoonLabel,
          _TimeOfDay.evening => eveningLabel,
        };

    return Padding(
      padding: padding,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(90),
          border: Border.all(
            color: theme.colorScheme.primary,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var timeOfDay in _TimeOfDay.values) ...[
              if (_isTimeWithinTimeOfDay(startTime, endTime, timeOfDay)) ...[
                GestureDetector(
                  onTap: () => updateSelectedTimeOfDay(timeOfDay),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: selectedTimeOfDay.selectedTimeOfDay == timeOfDay
                          ? theme.colorScheme.primary
                          : Colors.white,
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Text(
                        getLabelName(timeOfDay),
                        style: theme.textTheme.labelMedium?.copyWith(
                          color:
                              selectedTimeOfDay.selectedTimeOfDay == timeOfDay
                                  ? Colors.white
                                  : theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _TimeWrap<T> extends FormField<T> {
  _TimeWrap({
    required this.currentValue,
    required this.startTime,
    required this.finalTime,
    required this.interval,
    required this.onTap,
    required String? Function(T?) validate,
  }) : super(
          validator: (value) => validate(currentValue),
          builder: (FormFieldState<T> field) => Column(
            children: [
              Wrap(
                children: [
                  for (var i = startTime; i < finalTime; i += interval) ...[
                    _TimeWrapContent(
                      i: i,
                      currentValue: currentValue,
                      onTap: onTap,
                    ),
                  ],
                ],
              ),
              if (field.hasError) ...[
                FormFieldErrorBuilder(errorMessage: field.errorText!),
              ],
            ],
          ),
        );

  final T currentValue;
  final double startTime;
  final double finalTime;
  final double interval;
  final Function(double) onTap;
}

class _TimeWrapContent<T> extends StatelessWidget {
  const _TimeWrapContent({
    required this.i,
    required this.currentValue,
    required this.onTap,
  });

  final double i;
  final T currentValue;
  final Function(double) onTap;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var boxDecoration = BoxDecoration(
      color: currentValue == i.toString()
          ? theme.colorScheme.primary
          : Colors.white,
      borderRadius: BorderRadius.circular(16),
    );

    var decoratedBox = Container(
      decoration: boxDecoration,
      width: MediaQuery.of(context).size.width * .25,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 12,
        ),
        child: Text(
          '${i.floor().toString().padLeft(2, '0')}:'
          '${((i - i.floor()) * 60).toInt().toString().padLeft(2, '0')}',
          style: theme.textTheme.labelMedium?.copyWith(
            color: currentValue == i.toString()
                ? Colors.white
                : theme.colorScheme.primary,
          ),
        ),
      ),
    );

    return GestureDetector(
      onTap: () => onTap(i),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: decoratedBox,
      ),
    );
  }
}

class _SelectedTimeOfDay extends ChangeNotifier {
  _TimeOfDay? selection;
  String? time = "";

  _TimeOfDay? get selectedTimeOfDay => selection;
  String? get selectedTime => time;

  set selectedTimeOfDay(_TimeOfDay? value) {
    selection = value;
    notifyListeners();
  }

  set selectedTime(String? value) {
    time = value;
    notifyListeners();
  }
}

enum _TimeOfDay {
  morning(0, 12),
  afternoon(12, 18),
  evening(18, 24);

  const _TimeOfDay(this.minTime, this.maxTime);

  final double minTime;
  final double maxTime;
}
