import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_spacing.dart';
import '../models/tool_item.dart';
import 'tool_card.dart';

class HomeToolsGrid extends StatelessWidget {
  final List<ToolItem> tools;

  const HomeToolsGrid({
    super.key,
    required this.tools,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
      children: tools.map((tool) {
        return ToolCard(
          title: tool.title,
          icon: tool.icon,
          onTap: () {
            if (tool.useGo) {
              context.go(tool.route);
            } else {
              context.push(tool.route);
            }
          },
        );
      }).toList(),
    );
  }
}

