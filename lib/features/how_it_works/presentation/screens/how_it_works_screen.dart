import 'package:flutter/material.dart';

import '../../../../core/shared/widgets/custom_app_bar.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../data/constants/how_it_works_content.dart';
import '../widgets/info_card_widget.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'How It Works',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              ...HowItWorksContent.cards.map(
                (card) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: InfoCardWidget(card: card),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}
