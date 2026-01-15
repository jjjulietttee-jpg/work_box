import '../cubit/calculator_cubit.dart';

class CalculatorButtonHandler {
  static void handleButtonPress(
    CalculatorCubit cubit,
    String button,
  ) {
    switch (button) {
      case 'C':
        cubit.clear();
        break;
      case '⌫':
        cubit.backspace();
        break;
      case '%':
        cubit.percentage();
        break;
      case '÷':
        cubit.setOperation('/');
        break;
      case '×':
        cubit.setOperation('*');
        break;
      case '-':
        cubit.setOperation('-');
        break;
      case '+':
        cubit.setOperation('+');
        break;
      case '=':
        cubit.calculate();
        break;
      case '.':
        cubit.addDecimal();
        break;
      default:
        cubit.addDigit(button);
    }
  }
}

