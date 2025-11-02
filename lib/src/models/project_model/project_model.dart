// project_model.dart

import 'package:flutter/material.dart';
import 'package:root/src/core/constants/enums.dart';

@immutable
class ProjectModel {
  final int? id;
  final String? projectName;
  final bool hasTimeGoal;
  final int? timeGoalDurationMinutes;
  final TimeGoalFrequency? timeGoalFrequency;
  final TimeGoalRepeatingFrequency? timeGoalRepeatingFrequency;
  final DateTime? timeGoalOneTimeStartDate;
  final bool timeGoalOneTimeHasDeadlineDate;
  final DateTime? timeGoalOneTimeDeadlineDate;
  final int tagColor;

  const ProjectModel({
    this.projectName,
    this.tagColor = 0xFF42A5F5,
    this.id,
    this.hasTimeGoal = false,
    this.timeGoalDurationMinutes,
    this.timeGoalFrequency,
    this.timeGoalRepeatingFrequency,
    this.timeGoalOneTimeStartDate,
    this.timeGoalOneTimeHasDeadlineDate = false,
    this.timeGoalOneTimeDeadlineDate,
  });

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_name': projectName,
      'has_time_goal': hasTimeGoal,
      'time_goal_duration': timeGoalDurationMinutes,
      'time_goal_frequency': timeGoalFrequency?.name,
      'time_goal_repeating_frequency': timeGoalRepeatingFrequency?.name,
      'time_goal_one_time_start_date': timeGoalOneTimeStartDate
          ?.toIso8601String(),
      'time_goal_one_time_has_deadline_date': timeGoalOneTimeHasDeadlineDate,
      'time_goal_one_time_deadline_date': timeGoalOneTimeDeadlineDate
          ?.toIso8601String(),
      'tag_color': tagColor,
    };
  }

  // Create model from JSON
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as int,
      projectName: json['project_name'] as String,
      hasTimeGoal: json['has_time_goal'] as bool? ?? false,
      timeGoalDurationMinutes: json['time_goal_duration'] as int?,
      timeGoalFrequency: json['time_goal_frequency'] != null
          ? TimeGoalFrequency.values.firstWhere(
              (e) => e.name == json['time_goal_frequency'],
            )
          : null,
      timeGoalRepeatingFrequency: json['time_goal_repeating_frequency'] != null
          ? TimeGoalRepeatingFrequency.values.firstWhere(
              (e) => e.name == json['time_goal_repeating_frequency'],
            )
          : null,
      timeGoalOneTimeStartDate: json['time_goal_one_time_start_date'] != null
          ? DateTime.parse(json['time_goal_one_time_start_date'].toString())
          : null,
      timeGoalOneTimeHasDeadlineDate:
          json['time_goal_one_time_has_deadline_date'] as bool? ?? false,
      timeGoalOneTimeDeadlineDate:
          json['time_goal_one_time_deadline_date'] != null
          ? DateTime.parse(json['time_goal_one_time_deadline_date'].toString())
          : null,
      tagColor: json['tag_color'] as int,
    );
  }

  // Helper method to convert minutes to Duration
  Duration? get timeGoalDuration {
    return timeGoalDurationMinutes != null
        ? Duration(minutes: timeGoalDurationMinutes!)
        : null;
  }

  // Create a copy with modified fields
  ProjectModel copyWith({
    int? id,
    String? projectName,
    bool? hasTimeGoal,
    int? timeGoalDurationMinutes,
    TimeGoalFrequency? timeGoalFrequency,
    TimeGoalRepeatingFrequency? timeGoalRepeatingFrequency,
    DateTime? timeGoalOneTimeStartDate,
    bool? timeGoalOneTimeHasDeadlineDate,
    DateTime? timeGoalOneTimeDeadlineDate,
    int? tagColor,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      projectName: projectName ?? this.projectName,
      hasTimeGoal: hasTimeGoal ?? this.hasTimeGoal,
      timeGoalDurationMinutes:
          timeGoalDurationMinutes ?? this.timeGoalDurationMinutes,
      timeGoalFrequency: timeGoalFrequency ?? this.timeGoalFrequency,
      timeGoalRepeatingFrequency:
          timeGoalRepeatingFrequency ?? this.timeGoalRepeatingFrequency,
      timeGoalOneTimeStartDate:
          timeGoalOneTimeStartDate ?? this.timeGoalOneTimeStartDate,
      timeGoalOneTimeHasDeadlineDate:
          timeGoalOneTimeHasDeadlineDate ?? this.timeGoalOneTimeHasDeadlineDate,
      timeGoalOneTimeDeadlineDate:
          timeGoalOneTimeDeadlineDate ?? this.timeGoalOneTimeDeadlineDate,
      tagColor: tagColor ?? this.tagColor,
    );
  }

  @override
  String toString() {
    return 'ProjectModel(id: $id, projectName: $projectName, hasTimeGoal: $hasTimeGoal, timeGoalDurationMinutes: $timeGoalDurationMinutes, timeGoalFrequency: $timeGoalFrequency, timeGoalRepeatingFrequency: $timeGoalRepeatingFrequency, timeGoalOneTimeStartDate: $timeGoalOneTimeStartDate, timeGoalOneTimeHasDeadlineDate: $timeGoalOneTimeHasDeadlineDate, timeGoalOneTimeDeadlineDate: $timeGoalOneTimeDeadlineDate, tagColor: $tagColor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProjectModel &&
        other.id == id &&
        other.projectName == projectName &&
        other.hasTimeGoal == hasTimeGoal &&
        other.timeGoalDurationMinutes == timeGoalDurationMinutes &&
        other.timeGoalFrequency == timeGoalFrequency &&
        other.timeGoalRepeatingFrequency == timeGoalRepeatingFrequency &&
        other.timeGoalOneTimeStartDate == timeGoalOneTimeStartDate &&
        other.timeGoalOneTimeHasDeadlineDate ==
            timeGoalOneTimeHasDeadlineDate &&
        other.timeGoalOneTimeDeadlineDate == timeGoalOneTimeDeadlineDate &&
        other.tagColor == tagColor;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      projectName,
      hasTimeGoal,
      timeGoalDurationMinutes,
      timeGoalFrequency,
      timeGoalRepeatingFrequency,
      timeGoalOneTimeStartDate,
      timeGoalOneTimeHasDeadlineDate,
      timeGoalOneTimeDeadlineDate,
      tagColor,
    );
  }
}
