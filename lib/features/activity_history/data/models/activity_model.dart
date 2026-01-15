import '../../domain/entities/activity_item.dart';

class ActivityModel extends ActivityItem {
  const ActivityModel({
    required super.id,
    required super.type,
    required super.description,
    required super.timestamp,
    super.metadata,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'] as String,
      type: ActivityType.values.firstWhere(
        (e) => e.name == json['type'] as String,
        orElse: () => ActivityType.calculationPerformed,
      ),
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      metadata: json['metadata'] != null
          ? Map<String, String>.from(json['metadata'] as Map)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      if (metadata != null) 'metadata': metadata,
    };
  }

  factory ActivityModel.fromEntity(ActivityItem item) {
    return ActivityModel(
      id: item.id,
      type: item.type,
      description: item.description,
      timestamp: item.timestamp,
      metadata: item.metadata,
    );
  }
}
