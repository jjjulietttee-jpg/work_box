import 'package:flutter/material.dart';

class NavigationConstants {
  static const String home = '/home';
  static const String notes = '/notes';
  static const String calculator = '/calculator';
  static const String converter = '/converter';
  static const String settings = '/settings';
  static const String privacyPolicy = '/settings/privacy-policy';
  static const String termsOfUse = '/settings/terms-of-use';
  static const String activityHistory = '/activity-history';
  static const String howItWorks = '/how-it-works';
  
  static const Duration fastTransition = Duration(milliseconds: 200);
  static const Duration normalTransition = Duration(milliseconds: 350);
  static const Duration slowTransition = Duration(milliseconds: 500);
  
  static const Curve easeInOutCurve = Curves.easeInOut;
  static const Curve easeOutBackCurve = Curves.easeOutBack;
  static const Curve fastOutSlowInCurve = Curves.fastOutSlowIn;
}