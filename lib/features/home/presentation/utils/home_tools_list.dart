import 'package:flutter/material.dart';

import '../../../../core/navigation/data/constants/navigation_constants.dart';
import '../models/tool_item.dart';

class HomeToolsList {
  static const List<ToolItem> tools = [
    ToolItem(
      title: 'Notes',
      icon: Icons.note,
      route: NavigationConstants.notes,
    ),
    ToolItem(
      title: 'Calculator',
      icon: Icons.calculate,
      route: NavigationConstants.calculator,
    ),
    ToolItem(
      title: 'Converter',
      icon: Icons.swap_horiz,
      route: NavigationConstants.converter,
    ),
    ToolItem(
      title: 'Settings',
      icon: Icons.settings,
      route: NavigationConstants.settings,
      useGo: true,
    ),
  ];
}

