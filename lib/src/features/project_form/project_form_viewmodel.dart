// ignore_for_file: unused_field

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/core/constants/enums.dart';
import 'package:root/src/core/navigation/router.dart';
import 'package:root/src/models/project_model/project_model.dart';
import 'package:root/src/repositories/productivity_project_repository.dart';

class ProjectViewModel {
  final ProductivityProjectRepository _projectProductivityRepository;

  static ProjectViewModel? _instance;

  factory ProjectViewModel({
    ProductivityProjectRepository? projectProductivityRepository,
  }) {
    _instance ??= ProjectViewModel._internal(
      projectProductivityRepository: projectProductivityRepository,
    );
    return _instance!;
  }

  ProjectViewModel._internal({
    ProductivityProjectRepository? projectProductivityRepository,
  }) : _projectProductivityRepository =
           projectProductivityRepository ?? ProductivityProjectRepository();

  static void reset() {
    _instance?.dispose();
    _instance = null;
  }

  final ValueNotifier<ViewModelState<String>> projectFormState = ValueNotifier(
    ViewModelState.idle(data: ''),
  );

  final ValueNotifier<bool> timeGoalToggleValue = ValueNotifier(false);
  final ValueNotifier<Duration> timeGoalDuration = ValueNotifier(
    const Duration(hours: 1, minutes: 30),
  );
  final ValueNotifier<TimeGoalFrequency> frequencyType = ValueNotifier(
    TimeGoalFrequency.recurring,
  );

  // ⭐ Fixed: Separate notifier for repeating frequency
  final ValueNotifier<TimeGoalRepeatingFrequency> repeatingFrequency =
      ValueNotifier(
        TimeGoalRepeatingFrequency.daily,
      );

  final ValueNotifier<DateTime> oneTimeGoalStartDate = ValueNotifier(
    DateTime.now().add(const Duration(hours: 1)),
  );
  final ValueNotifier<bool> oneTimeHasDeadline = ValueNotifier(false);
  final ValueNotifier<DateTime> oneTimeDeadlineDate = ValueNotifier(
    DateTime.now().add(const Duration(days: 7)),
  );
  final ValueNotifier<int> colorTag = ValueNotifier(0xFF42A5F5);

  ProjectModel projectModel = const ProjectModel();

  String? validateForm(String projectName) {
    if (projectName.isEmpty) {
      return 'Project name is required';
    }

    if (projectName.length < 3) {
      return 'Project name must be at least 3 characters';
    }

    if (timeGoalToggleValue.value && timeGoalDuration.value.inMinutes <= 0) {
      return 'Duration must be greater than 0';
    }

    if (timeGoalToggleValue.value &&
        frequencyType.value == TimeGoalFrequency.onetime) {
      if (oneTimeGoalStartDate.value.isBefore(DateTime.now())) {
        return 'Start date cannot be in the past';
      }

      if (oneTimeHasDeadline.value &&
          oneTimeDeadlineDate.value.isBefore(oneTimeGoalStartDate.value)) {
        return 'Deadline date must be after start date';
      }
    }

    return null;
  }

  ProjectModel buildProjectModel(String projectName) {
    final validationError = validateForm(projectName);
    if (validationError != null) {
      throw Exception(validationError);
    }

    final isRecurring = frequencyType.value == TimeGoalFrequency.recurring;

    return ProjectModel(
      projectName: projectName,
      tagColor: colorTag.value,
      hasTimeGoal: timeGoalToggleValue.value,

      // ⭐ If time goal is disabled, set all time goal related fields to null
      timeGoalDurationMinutes: timeGoalToggleValue.value
          ? timeGoalDuration.value.inMinutes
          : null,

      // ⭐ Set frequency type only if time goal is enabled
      timeGoalFrequency: timeGoalToggleValue.value ? frequencyType.value : null,

      // ⭐ RECURRING SPECIFIC: Set repeating frequency only for recurring goals
      timeGoalRepeatingFrequency: timeGoalToggleValue.value && isRecurring
          ? repeatingFrequency.value
          : null,

      // ⭐ ONE-TIME SPECIFIC: Set start date only for one-time goals
      timeGoalOneTimeStartDate: timeGoalToggleValue.value && !isRecurring
          ? oneTimeGoalStartDate.value
          : null,

      // ⭐ ONE-TIME SPECIFIC: Set has deadline flag only for one-time goals
      // ignore: avoid_bool_literals_in_conditional_expressions
      timeGoalOneTimeHasDeadlineDate: timeGoalToggleValue.value && !isRecurring
          ? oneTimeHasDeadline.value
          : false,

      // ⭐ ONE-TIME SPECIFIC: Set deadline date only if all conditions met
      timeGoalOneTimeDeadlineDate:
          timeGoalToggleValue.value && !isRecurring && oneTimeHasDeadline.value
          ? oneTimeDeadlineDate.value
          : null,
    );
  }

  // ⭐ Function to save project
  Future<void> saveProject(String projectName) async {
    try {
      final model = buildProjectModel(projectName);

      log('✅ Project saved: ${model.projectName}');
      log('📋 Model: $model');

      await _projectProductivityRepository.saveProjectFromViewModel(
        model,
      );
      reset();
      router.pop();
    } catch (e) {
      log('❌ Error saving project: $e');
      projectFormState.value = ViewModelState.error(
        error: e.toString().extractMessage,
      );
    }
  }

  // ⭐ Function to reset form to initial state
  void resetForm() {
    timeGoalToggleValue.value = false;
    timeGoalDuration.value = const Duration(hours: 1, minutes: 30);
    frequencyType.value = TimeGoalFrequency.recurring;
    repeatingFrequency.value = TimeGoalRepeatingFrequency.daily;
    oneTimeGoalStartDate.value = DateTime.now();
    oneTimeHasDeadline.value = false;
    oneTimeDeadlineDate.value = DateTime.now().add(const Duration(days: 7));
    colorTag.value = 0xFF42A5F5;
    projectFormState.value = ViewModelState.idle(data: '');

    log('🔄 Form reset to initial state');
  }

  void dispose() {
    projectFormState.dispose();
    timeGoalToggleValue.dispose();
    timeGoalDuration.dispose();
    frequencyType.dispose();
    repeatingFrequency.dispose(); // ⭐ Fixed: Added missing dispose
    oneTimeGoalStartDate.dispose();
    oneTimeHasDeadline.dispose();
    oneTimeDeadlineDate.dispose();
  }
}

extension StringExtension on String {
  String get extractMessage {
    if (startsWith('Exception: ')) {
      return replaceFirst('Exception: ', '');
    }
    return this;
  }
}
