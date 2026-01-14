import 'package:root/src/repositories/select_exams_repository.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';
import 'package:root/src/models/exam_model/exam_model.dart';
import 'package:root/src/core/constants/enums.dart';
import 'package:flutter/material.dart';

class SelectExamsViewModel {
  final SelectExamsRepository _selectExamsRepository;

  SelectExamsViewModel({SelectExamsRepository? selectExamsRepository})
    : _selectExamsRepository = selectExamsRepository ?? SelectExamsRepository();

  final ValueNotifier<ViewModelState<String>> selectExamState = ValueNotifier(ViewModelState.idle(data: ''));

  List<Exam> exams = [];

  Future<void> getExams() async {
    selectExamState.value = ViewModelState.loading();

    try {
      final response = await _selectExamsRepository.getExams();
      exams = response;
      selectExamState.value = ViewModelState.success(
        type: SelectExamSuccessType.examFetched.toString(),
        data: 'Exams fetched successfully',
      );
    } catch (e) {
      selectExamState.value = ViewModelState.error(type: SelectExamErrorType.examFetchError.toString(), error: e.toString());
    }
  }

  Future<void> handleSelectedExams(List<String> selectedIds) async {
    selectExamState.value = ViewModelState.loading();
    final data = {"exams": selectedIds};
    try {
      await _selectExamsRepository.updateUserExams(data: data);
      selectExamState.value = ViewModelState.success(type: SelectExamSuccessType.examUpdated.toString());
    } catch (e) {
      selectExamState.value = ViewModelState.error(type: SelectExamErrorType.examUpdateError.toString(), error: e.toString());
    }
  }
}
