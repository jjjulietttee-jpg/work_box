import 'package:flutter/material.dart';

class NavigationIcons {
  NavigationIcons._();

  static const IconData home = Icons.home;
  static const IconData notes = Icons.note;
  static const IconData calculator = Icons.calculate;
  static const IconData settings = Icons.settings;
  
  static IconData getIconByRoute(String route) {
    switch (route) {
      case '/home':
        return home;
      case '/notes':
        return notes;
      case '/calculator':
        return calculator;
      case '/settings':
        return settings;
      default:
        return home;
    }
  }
}

