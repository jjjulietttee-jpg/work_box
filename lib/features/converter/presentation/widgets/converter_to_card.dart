import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/shared/widgets/glow_text_field.dart';
import '../../../../core/shared/widgets/animated_dropdown.dart';

class ConverterToCard extends StatefulWidget {
  final String value;
  final String selectedUnit;
  final List<String> availableUnits;
  final ValueChanged<String> onUnitChanged;

  const ConverterToCard({
    super.key,
    required this.value,
    required this.selectedUnit,
    required this.availableUnits,
    required this.onUnitChanged,
  });

  @override
  State<ConverterToCard> createState() => _ConverterToCardState();
}

class _ConverterToCardState extends State<ConverterToCard> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didUpdateWidget(ConverterToCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value == '0') {
        _controller.clear();
      } else {
        _controller.text = widget.value;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'To',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: context.textSecondaryColor,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          GlowTextField(
            controller: _controller,
            readOnly: true,
            hintText: widget.value == '0' ? 'Result' : null,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          AnimatedDropdown<String>(
            value: widget.selectedUnit,
            items: widget.availableUnits,
            itemBuilder: (unit) => unit,
            onChanged: widget.onUnitChanged,
          ),
        ],
      ),
    );
  }
}

