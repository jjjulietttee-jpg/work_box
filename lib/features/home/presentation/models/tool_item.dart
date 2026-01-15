import 'package:flutter/material.dart';

class ToolItem {
  final String title;
  final IconData icon;
  final String route;
  final bool useGo;

  const ToolItem({
    required this.title,
    required this.icon,
    required this.route,
    this.useGo = false,
  });
}

