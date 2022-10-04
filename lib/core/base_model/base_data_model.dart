class BaseDataModel<T> {
  BaseDataModel({
    this.status,
    this.errorMessage,
    this.data,
  });

  int? status;
  String? errorMessage;
  T? data;
}
