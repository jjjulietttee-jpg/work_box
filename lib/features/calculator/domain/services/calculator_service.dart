class CalculatorService {
  /// Evaluates a mathematical expression with proper operator precedence
  /// Supports: +, -, *, /, %, parentheses
  /// Returns the result as a double, or null if expression is invalid
  double? evaluate(String expression) {
    try {
      // Remove whitespace
      expression = expression.replaceAll(' ', '');
      
      if (expression.isEmpty) return null;
      
      // Handle division by zero
      if (expression.contains('/0') || expression.contains('/0.0')) {
        throw Exception('Division by zero');
      }
      
      // Parse and evaluate
      final tokens = _tokenize(expression);
      final postfix = _infixToPostfix(tokens);
      return _evaluatePostfix(postfix);
    } catch (e) {
      return null;
    }
  }

  /// Tokenizes the expression into numbers and operators
  List<String> _tokenize(String expression) {
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
          // Handle negative numbers
          currentNumber = '-';
        } else if (_isOperator(char) || char == '(' || char == ')') {
          tokens.add(char);
        }
      }
    }
    
    if (currentNumber.isNotEmpty) {
      tokens.add(currentNumber);
    }
    
    return tokens;
  }

  /// Converts infix notation to postfix (RPN) using Shunting Yard algorithm
  List<String> _infixToPostfix(List<String> tokens) {
    final List<String> output = [];
    final List<String> operators = [];
    
    for (final token in tokens) {
      if (_isNumber(token)) {
        output.add(token);
      } else if (token == '(') {
        operators.add(token);
      } else if (token == ')') {
        while (operators.isNotEmpty && operators.last != '(') {
          output.add(operators.removeLast());
        }
        if (operators.isNotEmpty && operators.last == '(') {
          operators.removeLast();
        }
      } else if (_isOperator(token)) {
        while (operators.isNotEmpty &&
            operators.last != '(' &&
            _getPrecedence(operators.last) >= _getPrecedence(token)) {
          output.add(operators.removeLast());
        }
        operators.add(token);
      }
    }
    
    while (operators.isNotEmpty) {
      output.add(operators.removeLast());
    }
    
    return output;
  }

  /// Evaluates postfix (RPN) expression
  double _evaluatePostfix(List<String> postfix) {
    final List<double> stack = [];
    
    for (final token in postfix) {
      if (_isNumber(token)) {
        stack.add(double.parse(token));
      } else if (_isOperator(token)) {
        if (stack.length < 2) {
          throw Exception('Invalid expression');
        }
        
        final b = stack.removeLast();
        final a = stack.removeLast();
        
        double result;
        switch (token) {
          case '+':
            result = a + b;
            break;
          case '-':
            result = a - b;
            break;
          case '*':
            result = a * b;
            break;
          case '/':
            if (b == 0) {
              throw Exception('Division by zero');
            }
            result = a / b;
            break;
          case '%':
            if (b == 0) {
              throw Exception('Modulo by zero');
            }
            result = a % b;
            break;
          default:
            throw Exception('Unknown operator: $token');
        }
        
        stack.add(result);
      }
    }
    
    if (stack.length != 1) {
      throw Exception('Invalid expression');
    }
    
    return stack.first;
  }

  bool _isDigit(String char) {
    return char.length == 1 && char.codeUnitAt(0) >= 48 && char.codeUnitAt(0) <= 57;
  }

  bool _isNumber(String token) {
    return double.tryParse(token) != null;
  }

  bool _isOperator(String token) {
    return ['+', '-', '*', '/', '%'].contains(token);
  }

  int _getPrecedence(String operator) {
    switch (operator) {
      case '+':
      case '-':
        return 1;
      case '*':
      case '/':
      case '%':
        return 2;
      default:
        return 0;
    }
  }

  /// Formats a number for display (removes trailing zeros)
  String formatResult(double value) {
    if (value.isInfinite || value.isNaN) {
      return 'Error';
    }
    
    // Check if it's a whole number
    if (value % 1 == 0) {
      return value.toInt().toString();
    }
    
    // Format with up to 10 decimal places, then remove trailing zeros
    final formatted = value.toStringAsFixed(10);
    return formatted.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
  }
}

