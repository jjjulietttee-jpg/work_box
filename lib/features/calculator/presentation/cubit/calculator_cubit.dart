import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/services/calculator_service.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  final CalculatorService _service;

  CalculatorCubit({CalculatorService? service})
      : _service = service ?? CalculatorService(),
        super(CalculatorState());

  void addDigit(String digit) {
    if (state.hasError) {
      clear();
    }
    
    final newExpression = state.expression.isEmpty 
        ? digit 
        : state.expression + digit;
    
    emit(state.copyWith(
      expression: newExpression,
      result: '0',
      hasError: false,
    ));
  }

  void addDecimal() {
    if (state.hasError) {
      clear();
    }
    
    // Check if last token already has a decimal point
    final tokens = _getLastToken();
    if (tokens.isEmpty || tokens.last.contains('.')) {
      return;
    }
    
    final newExpression = state.expression.isEmpty 
        ? '0.' 
        : state.expression + '.';
    
    emit(state.copyWith(
      expression: newExpression,
      result: '0',
      hasError: false,
    ));
  }

  void setOperation(String operation) {
    if (state.hasError) {
      clear();
    }
    
    String newExpression;
    
    if (state.expression.isEmpty) {
      newExpression = '0$operation';
    } else {
      final lastChar = state.expression[state.expression.length - 1];
      if (_isOperator(lastChar)) {
        // Replace last operator
        newExpression = state.expression.substring(0, state.expression.length - 1) + operation;
      } else {
        newExpression = state.expression + operation;
      }
    }
    
    emit(state.copyWith(
      expression: newExpression,
      result: '0',
      hasError: false,
    ));
  }

  void calculate() {
    if (state.expression.isEmpty || state.hasError) {
      return;
    }
    
    // Remove trailing operators
    String expression = state.expression;
    while (expression.isNotEmpty && _isOperator(expression[expression.length - 1])) {
      expression = expression.substring(0, expression.length - 1);
    }
    
    if (expression.isEmpty) {
      return;
    }
    
    final result = _service.evaluate(expression);
    
    if (result == null) {
      emit(state.copyWith(
        result: 'Error',
        hasError: true,
      ));
    } else {
      final formattedResult = _service.formatResult(result);
      emit(state.copyWith(
        expression: '',
        result: formattedResult,
        hasError: false,
      ));
    }
  }

  void clear() {
    emit(CalculatorState());
  }

  void backspace() {
    if (state.hasError) {
      clear();
      return;
    }
    
    if (state.expression.isEmpty) {
      return;
    }
    
    final newExpression = state.expression.substring(0, state.expression.length - 1);
    emit(state.copyWith(
      expression: newExpression,
      result: '0',
      hasError: false,
    ));
  }

  void toggleSign() {
    if (state.hasError || state.expression.isEmpty) {
      return;
    }
    
    // Find the last number in the expression
    final lastNumber = _getLastNumber();
    if (lastNumber == null) {
      return;
    }
    
    final value = double.tryParse(lastNumber);
    if (value == null || value == 0) {
      return;
    }
    
    final negatedValue = -value;
    final newExpression = state.expression.substring(
      0,
      state.expression.length - lastNumber.length,
    ) + _service.formatResult(negatedValue);
    
    emit(state.copyWith(
      expression: newExpression,
      result: '0',
      hasError: false,
    ));
  }

  void percentage() {
    if (state.hasError || state.expression.isEmpty) {
      return;
    }
    
    final lastNumber = _getLastNumber();
    if (lastNumber == null) {
      return;
    }
    
    final value = double.tryParse(lastNumber);
    if (value == null) {
      return;
    }
    
    final percentageValue = value / 100;
    final newExpression = state.expression.substring(
      0,
      state.expression.length - lastNumber.length,
    ) + _service.formatResult(percentageValue);
    
    emit(state.copyWith(
      expression: newExpression,
      result: '0',
      hasError: false,
    ));
  }

  String? _getLastNumber() {
    if (state.expression.isEmpty) return null;
    
    final tokens = _tokenizeExpression(state.expression);
    if (tokens.isEmpty) return null;
    
    final lastToken = tokens.last;
    if (_isNumber(lastToken)) {
      return lastToken;
    }
    
    return null;
  }

  List<String> _getLastToken() {
    return _tokenizeExpression(state.expression);
  }

  List<String> _tokenizeExpression(String expression) {
    final List<String> tokens = [];
    String currentNumber = '';
    
    for (int i = 0; i < expression.length; i++) {
      final char = expression[i];
      
      if (_isDigit(char) || char == '.') {
        currentNumber += char;
      } else {
        if (currentNumber.isNotEmpty) {
          tokens.add(currentNumber);
          currentNumber = '';
        }
        
        if (char == '-' && (tokens.isEmpty || _isOperator(tokens.last))) {
          currentNumber = '-';
        } else if (_isOperator(char)) {
          tokens.add(char);
        }
      }
    }
    
    if (currentNumber.isNotEmpty) {
      tokens.add(currentNumber);
    }
    
    return tokens;
  }

  bool _isDigit(String char) {
    return char.length == 1 && char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57;
  }

  bool _isNumber(String token) {
    return double.tryParse(token) != null;
  }

  bool _isOperator(String char) {
    return ['+', '-', '*', '/', '%'].contains(char);
  }
}

