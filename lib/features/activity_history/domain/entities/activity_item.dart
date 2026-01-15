import 'package:equatable/equatable.dart';

enum ActivityType {
  calculationPerformed,
  conversionPerformed,
  entityCreated,
  dataReset,
  appFirstLaunch,
}

class ActivityItem extends Equatable {
  final String id;
  final ActivityType type;
  final String description;
  final DateTime timestamp;
  final Map<String, String>? metadata;

  const ActivityItem({
    required this.id,
    required this.type,
    required this.description,
    required this.timestamp,
    this.metadata,
  });

  ActivityItem copyWith({
    String? id,
    ActivityType? type,
    String? description,
    DateTime? timestamp,
    Map<String, String>? metadata,
  }) {
    return ActivityItem(
      id: id ?? this.id,
      type: type ?? this.type,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [id, type, description, timestamp, metadata];
}
