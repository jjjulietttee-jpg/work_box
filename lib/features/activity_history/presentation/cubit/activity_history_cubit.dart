import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/activity_item.dart';
import '../../domain/usecases/get_activity_history.dart';
import '../../domain/usecases/add_activity.dart';
import '../../domain/usecases/clear_activity_history.dart';
import '../../../../core/services/logger_service.dart';

part 'activity_history_state.dart';

class ActivityHistoryCubit extends Cubit<ActivityHistoryState> {
  final GetActivityHistory getActivityHistory;
  final AddActivity addActivity;
  final ClearActivityHistory clearActivityHistory;

  ActivityHistoryCubit({
    required this.getActivityHistory,
    required this.addActivity,
    required this.clearActivityHistory,
  }) : super(ActivityHistoryInitial());

  Future<void> loadActivities() async {
    emit(ActivityHistoryLoading());
    try {
      final activities = await getActivityHistory();
      emit(ActivityHistoryLoaded(activities: activities));
    } catch (e) {
      LoggerService.error('Failed to load activity history', e);
      emit(ActivityHistoryError('Failed to load activity history'));
    }
  }

  Future<void> recordActivity(ActivityItem activity) async {
    try {
      await addActivity(activity);
      await loadActivities();
    } catch (e) {
      LoggerService.error('Failed to record activity', e);
    }
  }

  Future<void> clearHistory() async {
    try {
      await clearActivityHistory();
      emit(ActivityHistoryLoaded(activities: []));
    } catch (e) {
      LoggerService.error('Failed to clear activity history', e);
      emit(ActivityHistoryError('Failed to clear activity history'));
    }
  }
}
