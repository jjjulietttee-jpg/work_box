import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/activity_model.dart';

abstract class ActivityLocalDataSource {
  Future<List<ActivityModel>> getActivities();
  Future<void> addActivity(ActivityModel activity);
  Future<void> clearActivities();
}

class ActivityLocalDataSourceImpl implements ActivityLocalDataSource {
  final SharedPreferences prefs;
  static const String _keyActivities = 'activity_history';
  static const int _maxActivities = 100;

  ActivityLocalDataSourceImpl(this.prefs);

  @override
  Future<List<ActivityModel>> getActivities() async {
    final activitiesJson = prefs.getString(_keyActivities);
    if (activitiesJson == null) return [];
    try {
      final List<dynamic> decoded = jsonDecode(activitiesJson) as List<dynamic>;
      final activities = decoded
          .map((json) => ActivityModel.fromJson(json as Map<String, dynamic>))
          .toList();
      activities.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return activities;
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> addActivity(ActivityModel activity) async {
    final activities = await getActivities();
    activities.insert(0, activity);
    
    if (activities.length > _maxActivities) {
      activities.removeRange(_maxActivities, activities.length);
    }
    
    await prefs.setString(
      _keyActivities,
      jsonEncode(activities.map((a) => a.toJson()).toList()),
    );
  }

  @override
  Future<void> clearActivities() async {
    await prefs.remove(_keyActivities);
  }
}
