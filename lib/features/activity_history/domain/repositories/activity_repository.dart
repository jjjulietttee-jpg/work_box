import '../entities/activity_item.dart';

abstract class ActivityRepository {
  Future<List<ActivityItem>> getActivities();
  Future<void> addActivity(ActivityItem activity);
  Future<void> clearActivities();
}
