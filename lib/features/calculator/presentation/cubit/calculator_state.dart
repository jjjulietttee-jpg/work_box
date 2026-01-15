part of 'calculator_cubit.dart';

class CalculatorState extends Equatable {
  final String expression;
  final String result;
  final bool hasError;

  const CalculatorState({
    this.expression = '',
    this.result = '0',
    this.hasError = false,
  });

  CalculatorState copyWith({
    String? expression,
    String? result,
    bool? hasError,
  }) {
    return CalculatorState(
      expression: expression ?? this.expression,
      result: result ?? this.result,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  List<Object?> get props => [expression, result, hasError];
}

