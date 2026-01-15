import 'package:flutter/material.dart';

import '../../../../core/shared/widgets/segmented_selector.dart';
import '../cubit/converter_cubit.dart';

class ConverterTypeSelector extends StatelessWidget {
  final ConverterType selectedType;
  final ValueChanged<ConverterType> onTypeChanged;

  const ConverterTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedSelector<ConverterType>(
      selectedValue: selectedType,
      onValueChanged: onTypeChanged,
      segments: const [
        SegmentItem(
          value: ConverterType.length,
          label: 'Length',
          icon: Icons.straighten,
        ),
        SegmentItem(
          value: ConverterType.weight,
          label: 'Weight',
          icon: Icons.scale,
        ),
        SegmentItem(
          value: ConverterType.temperature,
          label: 'Temp',
          icon: Icons.thermostat,
        ),
      ],
    );
  }
}

