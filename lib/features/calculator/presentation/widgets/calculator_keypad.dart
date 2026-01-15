import 'package:flutter/material.dart';

import '../../../../core/theme/app_border_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';
import 'calculator_button_row.dart';

class CalculatorKeypad extends StatelessWidget {
  final ValueChanged<String> onButtonPressed;

  const CalculatorKeypad({
    super.key,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: context.cardBgColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppBorderRadius.lg),
        ),
      ),
      child: Column(
        children: [
          CalculatorButtonRow(
            buttons: const ['C', '⌫', '%', '÷'],
            onButtonPressed: onButtonPressed,
          ),
          const SizedBox(height: AppSpacing.xs),
          CalculatorButtonRow(
            buttons: const ['7', '8', '9', '×'],
            onButtonPressed: onButtonPressed,
          ),
          const SizedBox(height: AppSpacing.xs),
          CalculatorButtonRow(
            buttons: const ['4', '5', '6', '-'],
            onButtonPressed: onButtonPressed,
          ),
          const SizedBox(height: AppSpacing.xs),
          CalculatorButtonRow(
            buttons: const ['1', '2', '3', '+'],
            onButtonPressed: onButtonPressed,
          ),
          const SizedBox(height: AppSpacing.xs),
          CalculatorButtonRow(
            buttons: const ['0', '.', '='],
            isLastRow: true,
            onButtonPressed: onButtonPressed,
          ),
        ],
      ),
    );
  }
}

