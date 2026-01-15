import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/shared/widgets/custom_app_bar.dart';
import '../cubit/converter_cubit.dart';
import '../widgets/converter_type_selector.dart';
import '../widgets/converter_from_card.dart';
import '../widgets/converter_swap_button.dart';
import '../widgets/converter_to_card.dart';

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Converter'),
      body: SafeArea(
        child: BlocBuilder<ConverterCubit, ConverterState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: AppSpacing.md,
                right: AppSpacing.md,
                top: AppSpacing.md,
                bottom: 350,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.sm),
                  ConverterTypeSelector(
                    selectedType: state.converterType,
                    onTypeChanged: (type) {
                      context.read<ConverterCubit>().setConverterType(type);
                    },
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ConverterFromCard(
                    value: state.fromValue,
                    selectedUnit: state.fromUnit,
                    availableUnits: state.availableUnits,
                    onValueChanged: (value) {
                      context.read<ConverterCubit>().setFromValue(value);
                    },
                    onUnitChanged: (unit) {
                      context.read<ConverterCubit>().setFromUnit(unit);
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ConverterSwapButton(
                    onTap: () {
                      context.read<ConverterCubit>().swapUnits();
                    },
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ConverterToCard(
                    value: state.toValue,
                    selectedUnit: state.toUnit,
                    availableUnits: state.availableUnits,
                    onUnitChanged: (unit) {
                      context.read<ConverterCubit>().setToUnit(unit);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
