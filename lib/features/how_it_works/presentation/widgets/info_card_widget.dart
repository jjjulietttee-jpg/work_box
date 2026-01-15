import 'package:flutter/material.dart';

import '../../../../core/shared/widgets/glass_card.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/constants/how_it_works_content.dart';

class InfoCardWidget extends StatelessWidget {
  final InfoCard card;

  const InfoCardWidget({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                card.icon,
                style: const TextStyle(fontSize: 32),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  card.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            card.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
