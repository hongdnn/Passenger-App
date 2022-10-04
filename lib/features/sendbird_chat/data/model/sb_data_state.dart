import 'package:sendbird_sdk/core/models/error.dart';

abstract class SBDataState<T> {
  const SBDataState({this.data, this.error});

  final T? data;
  final SBError? error;
}

class SBDataSuccess<T> extends SBDataState<T> {
  const SBDataSuccess(T data) : super(data: data);
}

class SBDataFailed<T> extends SBDataState<T> {
  const SBDataFailed(SBError error) : super(error: error);
}
