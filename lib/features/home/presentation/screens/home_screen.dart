import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../widgets/home_header.dart';
import '../widgets/home_tools_grid.dart';
import '../utils/home_tools_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              Expanded(
                child: HomeToolsGrid(tools: HomeToolsList.tools),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

