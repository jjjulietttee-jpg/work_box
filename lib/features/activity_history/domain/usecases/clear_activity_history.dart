import '../repositories/activity_repository.dart';

class ClearActivityHistory {
  final ActivityRepository repository;

  ClearActivityHistory(this.repository);

  Future<void> call() async {
    await repository.clearActivities();
  }
}
