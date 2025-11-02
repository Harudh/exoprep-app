import 'package:flutter/material.dart';
import 'package:root/src/core/common/state/viewmodel_state.dart';

import 'package:root/src/core/logger/logger.dart';
import 'package:root/src/repositories/productivity_project_repository.dart';

class ProductivityViewModel {
  // ignore: unused_field
  final ProductivityProjectRepository _productivityProjectRepository;

  ProductivityViewModel({
    ProductivityProjectRepository? productivityRepository,
  }) : _productivityProjectRepository =
           productivityRepository ?? ProductivityProjectRepository();

  final ValueNotifier<ViewModelState<dynamic>> productivityState =
      ValueNotifier(ViewModelState.idle());

  final ValueNotifier<DateTime> selectedDate = ValueNotifier(DateTime.now());
  final ValueNotifier<List<DateTime>> datesList = ValueNotifier([]);

  final ScrollController dateScrollController = ScrollController();
  bool isLoadingMoreDates = false;
  bool _isInitialized = false;

  void init() {
    // Prevent re-initialization
    if (_isInitialized) {
      AppLogs.debug('ProductivityViewModel already initialized');
      return;
    }

    _isInitialized = true;
    AppLogs.debug('ProductivityViewModel initialized');
  }

  // Reset method for testing or logout scenarios
  void reset() {
    selectedDate.value = DateTime.now();
    datesList.value = [];
    _isInitialized = false;
    isLoadingMoreDates = false;
    AppLogs.debug('ProductivityViewModel reset');
  }

  void dispose() {
    productivityState.dispose();
    selectedDate.dispose();
    datesList.dispose();
    dateScrollController.dispose();
  }
}
