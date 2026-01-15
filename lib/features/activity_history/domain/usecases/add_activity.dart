import '../entities/activity_item.dart';
import '../repositories/activity_repository.dart';

class AddActivity {
  final ActivityRepository repository;

  AddActivity(this.repository);

  Future<void> call(ActivityItem activity) async {
    await repository.addActivity(activity);
  }
}
