import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_extensions.dart';
import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/shared/widgets/glow_text_field.dart';
import '../../../../core/shared/widgets/animated_dropdown.dart';

class ConverterFromCard extends StatefulWidget {
  final double value;
  final String selectedUnit;
  final List<String> availableUnits;
  final ValueChanged<String> onValueChanged;
  final ValueChanged<String> onUnitChanged;

  const ConverterFromCard({
    super.key,
    required this.value,
    required this.selectedUnit,
    required this.availableUnits,
    required this.onValueChanged,
    required this.onUnitChanged,
  });

  @override
  State<ConverterFromCard> createState() => _ConverterFromCardState();
}

class _ConverterFromCardState extends State<ConverterFromCard> {
  late TextEditingController _controller;
  bool _isUserTyping = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didUpdateWidget(ConverterFromCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isUserTyping) {
      final currentText = _controller.text;
      final newValue = widget.value.toString();
      if (currentText != newValue) {
        if (widget.value == 0) {
          _controller.clear();
        } else {
          _controller.text = newValue;
          _controller.selection = TextSelection.fromPosition(
            TextPosition(offset: newValue.length),
          );
        }
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
            'From',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: context.textSecondaryColor,
                ),
          ),
          const SizedBox(height: AppSpacing.md),
          GlowTextField(
            controller: _controller,
            hintText: 'Enter value',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: context.textPrimaryColor,
                ),
            onChanged: (value) {
              if (value.isEmpty) {
                _isUserTyping = false;
                widget.onValueChanged('0');
              } else {
                _isUserTyping = true;
                final numValue = double.tryParse(value) ?? 0.0;
                widget.onValueChanged(numValue.toString());
              }
            },
            onFocusLost: () {
              _isUserTyping = false;
            },
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

