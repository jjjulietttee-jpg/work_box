import 'package:flutter/material.dart';

import '../../theme/app_border_radius.dart';
import '../../theme/app_spacing.dart';
import '../../theme/theme_extensions.dart';
import 'glass_card.dart';

class SegmentedSelector<T> extends StatefulWidget {
  final List<SegmentItem<T>> segments;
  final T selectedValue;
  final ValueChanged<T> onValueChanged;

  const SegmentedSelector({
    super.key,
    required this.segments,
    required this.selectedValue,
    required this.onValueChanged,
  });

  @override
  State<SegmentedSelector<T>> createState() => _SegmentedSelectorState<T>();
}

class _SegmentedSelectorState<T> extends State<SegmentedSelector<T>> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.segments
        .indexWhere((segment) => segment.value == widget.selectedValue);
    if (_selectedIndex == -1) _selectedIndex = 0;
  }

  @override
  void didUpdateWidget(SegmentedSelector<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedValue != widget.selectedValue) {
      _selectedIndex = widget.segments
          .indexWhere((segment) => segment.value == widget.selectedValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.xs),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = (constraints.maxWidth - AppSpacing.xs * 2) /
              widget.segments.length;
          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                left: _selectedIndex * itemWidth,
                child: Container(
                  width: itemWidth,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(AppBorderRadius.md),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                        blurRadius: 6,
                        spreadRadius: 0.5,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: widget.segments.asMap().entries.map((entry) {
                  final index = entry.key;
                  final segment = entry.value;
                  final isSelected = segment.value == widget.selectedValue;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _selectedIndex = index);
                        widget.onValueChanged(segment.value);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (segment.icon != null) ...[
                              Icon(
                                segment.icon,
                                size: 18,
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : context.textSecondaryColor,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                            ],
                            Text(
                              segment.label,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : context.textSecondaryColor,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SegmentItem<T> {
  final T value;
  final String label;
  final IconData? icon;

  const SegmentItem({
    required this.value,
    required this.label,
    this.icon,
  });
}

