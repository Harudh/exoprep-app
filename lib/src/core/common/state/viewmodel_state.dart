enum ViewModelStatus { idle, loading, success, error }

class ViewModelState<T> {
  final ViewModelStatus status;
  final dynamic data;
  final T? type;
  final String? error;

  const ViewModelState({required this.status, this.data, this.error, this.type});

  factory ViewModelState.idle({T? data}) => ViewModelState(status: ViewModelStatus.idle, data: data);

  factory ViewModelState.loading({T? mode}) => ViewModelState(status: ViewModelStatus.loading, data: mode);

  factory ViewModelState.success({dynamic data, T? type}) =>
      ViewModelState(status: ViewModelStatus.success, data: data, type: type);

  factory ViewModelState.error({String? error, T? type}) =>
      ViewModelState(status: ViewModelStatus.error, error: error, type: type);
}
