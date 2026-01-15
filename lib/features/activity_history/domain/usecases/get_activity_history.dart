import '../entities/activity_item.dart';
import '../repositories/activity_repository.dart';

class GetActivityHistory {
  final ActivityRepository repository;

  GetActivityHistory(this.repository);

  Future<List<ActivityItem>> call() async {
    return await repository.getActivities();
  }
}
