import '../models/navigation_item.dart';
import 'navigation_constants.dart';
import 'navigation_labels.dart';

class BottomNavigationConstants {
  BottomNavigationConstants._();

  static const List<NavigationItem> navigationItems = [
    NavigationItem(
      iconPath: '',
      label: NavigationLabels.home,
      route: NavigationConstants.home,
    ),
    NavigationItem(
      iconPath: '',
      label: NavigationLabels.notes,
      route: NavigationConstants.notes,
    ),
    NavigationItem(
      iconPath: '',
      label: NavigationLabels.calculator,
      route: NavigationConstants.calculator,
    ),
    NavigationItem(
      iconPath: '',
      label: NavigationLabels.settings,
      route: NavigationConstants.settings,
    ),
  ];
}
