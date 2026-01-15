import '../../domain/entities/activity_item.dart';
import '../../domain/repositories/activity_repository.dart';
import '../datasources/activity_local_datasource.dart';
import '../models/activity_model.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final ActivityLocalDataSource dataSource;

  ActivityRepositoryImpl(this.dataSource);

  @override
  Future<List<ActivityItem>> getActivities() async {
    final models = await dataSource.getActivities();
    return models;
  }

  @override
  Future<void> addActivity(ActivityItem activity) async {
    final model = ActivityModel.fromEntity(activity);
    await dataSource.addActivity(model);
  }

  @override
  Future<void> clearActivities() async {
    await dataSource.clearActivities();
  }
}
