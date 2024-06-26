import "package:flutter/material.dart";
import "package:flutter_order_details/flutter_order_details.dart";

/// Order Detail Screen.
class OrderDetailScreen extends StatefulWidget {
  /// Screen that builds all forms based on the configuration.
  const OrderDetailScreen({
    required this.configuration,
    super.key,
  });

  /// Configuration for the screen.
  final OrderDetailConfiguration configuration;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final _CurrentStep _currentStep = _CurrentStep();

  final OrderResult _orderResult = OrderResult(order: {});

  bool _blurBackground = false;

  void _toggleBlurBackground({bool? needsBlur}) {
    setState(() {
      _blurBackground = needsBlur!;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var pageBody = SafeArea(
      left: false,
      right: false,
      bottom: true,
      child: _OrderDetailBody(
        configuration: widget.configuration,
        orderResult: _orderResult,
        currentStep: _currentStep,
        onBlurBackground: _toggleBlurBackground,
      ),
    );

    var pageBlur = GestureDetector(
      onTap: () => _toggleBlurBackground(needsBlur: false),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface.withOpacity(0.5),
        ),
      ),
    );

    return Scaffold(
      appBar: widget.configuration.appBar,
      body: Stack(
        children: [
          pageBody,
          if (_blurBackground) pageBlur,
        ],
      ),
    );
  }
}

class _CurrentStep extends ChangeNotifier {
  int _step = 0;

  int get step => _step;

  void increment() {
    _step++;
    notifyListeners();
  }

  void decrement() {
    _step--;
    notifyListeners();
  }
}

class _OrderDetailBody extends StatelessWidget {
  const _OrderDetailBody({
    required this.configuration,
    required this.orderResult,
    required this.currentStep,
    required this.onBlurBackground,
  });

  final OrderDetailConfiguration configuration;
  final OrderResult orderResult;
  final _CurrentStep currentStep;
  final Function({bool needsBlur}) onBlurBackground;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: currentStep,
        builder: (context, _) => Builder(
          builder: (context) => _FormBuilder(
            currentStep: currentStep,
            orderResult: orderResult,
            configuration: configuration,
            onBlurBackground: onBlurBackground,
          ),
        ),
      );
}

class _FormBuilder extends StatelessWidget {
  const _FormBuilder({
    required this.currentStep,
    required this.configuration,
    required this.orderResult,
    required this.onBlurBackground,
  });

  final _CurrentStep currentStep;
  final OrderDetailConfiguration configuration;
  final OrderResult orderResult;

  final Function({bool needsBlur}) onBlurBackground;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    var progressIndicator = LinearProgressIndicator(
      value: currentStep.step / configuration.steps.length,
      backgroundColor: theme.colorScheme.surface,
    );

    var stepForm = Form(
      key: configuration.steps[currentStep.step].formKey,
      child: _StepBuilder(
        configuration: configuration,
        currentStep: configuration.steps[currentStep.step],
        orderResult: orderResult,
        theme: theme,
        onBlurBackground: onBlurBackground,
      ),
    );

    void onPressedNext() {
      var formInfo = configuration.steps[currentStep.step];
      var formkey = formInfo.formKey;
      for (var input in formInfo.fields) {
        orderResult.order[input.outputKey] = input.currentValue;
      }

      if (formkey.currentState!.validate()) {
        currentStep.increment();
      }
    }

    void onPressedPrevious() {
      var formInfo = configuration.steps[currentStep.step];
      for (var input in formInfo.fields) {
        orderResult.order[input.outputKey] = input.currentValue;
      }

      currentStep.decrement();
    }

    void onPressedComplete() {
      var formInfo = configuration.steps[currentStep.step];
      var formkey = formInfo.formKey;
      for (var input in formInfo.fields) {
        orderResult.order[input.outputKey] = input.currentValue;
      }

      if (formkey.currentState!.validate()) {
        configuration.onCompleted(orderResult);
      }
    }

    var navigationControl = Row(
      children: [
        if (currentStep.step > 0) ...[
          TextButton(
            onPressed: onPressedPrevious,
            child: Text(
              configuration.localization.backButton,
            ),
          ),
        ],
        const Spacer(),
        if (currentStep.step < configuration.steps.length - 1) ...[
          TextButton(
            onPressed: onPressedNext,
            child: Text(
              configuration.localization.nextButton,
            ),
          ),
        ] else ...[
          TextButton(
            onPressed: onPressedComplete,
            child: Text(
              configuration.localization.completeButton,
            ),
          ),
        ],
      ],
    );

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              if (configuration.progressIndicator) ...[
                progressIndicator,
              ],
              stepForm,
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: navigationControl,
        ),
      ],
    );
  }
}

class _StepBuilder extends StatelessWidget {
  const _StepBuilder({
    required this.configuration,
    required this.currentStep,
    required this.orderResult,
    required this.theme,
    required this.onBlurBackground,
  });

  final OrderDetailConfiguration configuration;
  final OrderDetailStep currentStep;
  final OrderResult orderResult;
  final ThemeData theme;
  final Function({bool needsBlur}) onBlurBackground;

  @override
  Widget build(BuildContext context) {
    var title = currentStep.stepName != null
        ? Padding(
            padding: configuration.titlePadding,
            child: Text(
              currentStep.stepName!,
              style: theme.textTheme.titleMedium,
            ),
          )
        : const SizedBox.shrink();

    return Column(
      children: [
        title,
        for (var input in currentStep.fields)
          Padding(
            padding: configuration.inputFieldPadding,
            child: input.build(
              context,
              orderResult.order[input.outputKey],
              onBlurBackground,
            ),
          ),
      ],
    );
  }
}
