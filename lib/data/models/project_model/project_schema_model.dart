import 'package:isar_community/isar.dart';
import 'package:root/src/core/constants/enums.dart';

part 'project_schema_model.g.dart';

@collection
class ProjectSchemaModel {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value)
  late String projectName;

  late bool hasTimeGoal;

  int? timeGoalDurationMinutes;

  @Enumerated(EnumType.name)
  TimeGoalFrequency? timeGoalFrequency;

  @Enumerated(EnumType.name)
  TimeGoalRepeatingFrequency? timeGoalRepeatingFrequency;

  DateTime? timeGoalOneTimeStartDate;

  late bool timeGoalOneTimeHasDeadlineDate;

  DateTime? timeGoalOneTimeDeadlineDate;

  @Index(type: IndexType.value)
  late int tagColor;

  @Index()
  DateTime? createdAt;

  DateTime? updatedAt;

  ProjectSchemaModel({
    required this.projectName,
    required this.tagColor,
    this.id = Isar.autoIncrement,
    this.hasTimeGoal = false,
    this.timeGoalDurationMinutes,
    this.timeGoalFrequency,
    this.timeGoalRepeatingFrequency,
    this.timeGoalOneTimeStartDate,
    this.timeGoalOneTimeHasDeadlineDate = false,
    this.timeGoalOneTimeDeadlineDate,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // ⭐ Add @ignore annotation to tell Isar to skip this getter
  @ignore
  Duration? get timeGoalDuration {
    return timeGoalDurationMinutes != null
        ? Duration(minutes: timeGoalDurationMinutes!)
        : null;
  }
}
