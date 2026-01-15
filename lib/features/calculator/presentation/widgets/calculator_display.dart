import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../cubit/calculator_cubit.dart';

class CalculatorDisplay extends StatelessWidget {
  final CalculatorState state;

  const CalculatorDisplay({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (state.expression.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: SingleChildScrollView(
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Text(
                  state.expression,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: context.textSecondaryColor,
                        fontSize: 20,
                      ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
          SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: Text(
              state.result,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 56,
                    color: state.hasError
                        ? Theme.of(context).colorScheme.error
                        : context.textPrimaryColor,
                    fontWeight: FontWeight.w300,
                  ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

