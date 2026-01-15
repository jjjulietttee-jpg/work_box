import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/shared/widgets/custom_app_bar.dart';
import '../cubit/calculator_cubit.dart';
import '../widgets/calculator_display.dart';
import '../widgets/calculator_keypad.dart';
import '../utils/calculator_button_handler.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Calculator'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: BlocBuilder<CalculatorCubit, CalculatorState>(
                  builder: (context, state) {
                    return CalculatorDisplay(state: state);
                  },
                ),
              ),
            ),
            CalculatorKeypad(
              onButtonPressed: (button) {
                final cubit = context.read<CalculatorCubit>();
                CalculatorButtonHandler.handleButtonPress(cubit, button);
              },
            ),
          ],
        ),
      ),
    );
  }
}
