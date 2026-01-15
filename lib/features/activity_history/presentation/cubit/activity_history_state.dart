part of 'activity_history_cubit.dart';

abstract class ActivityHistoryState extends Equatable {
  const ActivityHistoryState();

  @override
  List<Object> get props => [];
}

class ActivityHistoryInitial extends ActivityHistoryState {}

class ActivityHistoryLoading extends ActivityHistoryState {}

class ActivityHistoryLoaded extends ActivityHistoryState {
  final List<ActivityItem> activities;

  const ActivityHistoryLoaded({required this.activities});

  @override
  List<Object> get props => [activities];
}

class ActivityHistoryError extends ActivityHistoryState {
  final String message;

  const ActivityHistoryError(this.message);

  @override
  List<Object> get props => [message];
}
