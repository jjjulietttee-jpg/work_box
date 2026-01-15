import 'package:get_it/get_it.dart';

import '../../features/activity_history/domain/entities/activity_item.dart';
import '../../features/activity_history/presentation/cubit/activity_history_cubit.dart';

class ActivityTrackerService {
  ActivityTrackerService._();

  static ActivityHistoryCubit? get _cubit {
    try {
      return GetIt.instance<ActivityHistoryCubit>();
    } catch (_) {
      return null;
    }
  }

  static void _recordActivity(ActivityItem activity) {
    final cubit = _cubit;
    if (cubit != null) {
      cubit.recordActivity(activity);
    }
  }

  static void trackCalculation(String expression, String result) {
    _recordActivity(ActivityItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: ActivityType.calculationPerformed,
      description: '$expression = $result',
      timestamp: DateTime.now(),
      metadata: {
        'expression': expression,
        'result': result,
      },
    ));
  }

  static void trackConversion(String fromValue, String fromUnit, String toValue, String toUnit, String type) {
    final typeName = type == 'length' ? 'Length' : type == 'weight' ? 'Weight' : 'Temperature';
    _recordActivity(ActivityItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: ActivityType.conversionPerformed,
      description: '$fromValue $fromUnit = $toValue $toUnit ($typeName)',
      timestamp: DateTime.now(),
      metadata: {
        'fromValue': fromValue,
        'fromUnit': fromUnit,
        'toValue': toValue,
        'toUnit': toUnit,
        'type': type,
      },
    ));
  }

  static void trackEntityCreated(String entityType, {String? entityName}) {
    final description = entityName != null
        ? 'Created $entityType: $entityName'
        : 'Created $entityType';
    _recordActivity(ActivityItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: ActivityType.entityCreated,
      description: description,
      timestamp: DateTime.now(),
      metadata: {'type': entityType},
    ));
  }

  static void trackDataReset() {
    _recordActivity(ActivityItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: ActivityType.dataReset,
      description: 'Reset local data',
      timestamp: DateTime.now(),
    ));
  }

  static void trackAppFirstLaunch() {
    _recordActivity(ActivityItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: ActivityType.appFirstLaunch,
      description: 'App first launched',
      timestamp: DateTime.now(),
    ));
  }
}
