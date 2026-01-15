import 'package:flutter/material.dart';

import 'calculator_button.dart';

class CalculatorButtonRow extends StatelessWidget {
  final List<String> buttons;
  final bool isLastRow;
  final ValueChanged<String> onButtonPressed;

  const CalculatorButtonRow({
    super.key,
    required this.buttons,
    this.isLastRow = false,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: buttons.asMap().entries.map((entry) {
        final button = entry.value;
        final isZero = button == '0' && isLastRow;
        final isOperator = ['÷', '×', '-', '+'].contains(button);
        final isSpecial = ['C', '⌫', '%'].contains(button);
        final isEquals = button == '=';

        return Expanded(
          flex: isZero ? 2 : 1,
          child: CalculatorButton(
            label: button,
            isOperator: isOperator,
            isSpecial: isSpecial,
            isEquals: isEquals,
            onTap: () => onButtonPressed(button),
          ),
        );
      }).toList(),
    );
  }
}

