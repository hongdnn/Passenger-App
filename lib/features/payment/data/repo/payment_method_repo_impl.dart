import 'package:dio/dio.dart';
import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/booking_page/data/model/payment_method_model.dart';
import 'package:passenger/features/payment/data/model/payment_items_model.dart';
import 'package:passenger/features/payment/data/model/payment_method_default_request_model.dart';
import 'package:passenger/features/payment/data/model/payment_type_model.dart';
import 'package:passenger/features/payment/data/repo/payment_method_repo.dart';

class PaymentMethodRepoImpl implements PaymentMethodRepo {
  PaymentMethodRepoImpl(this._baseApi);

  final RhBaseApi _baseApi;

  @override
  Future<DataState<PaymentMethodModel>> getDefaultPaymentMethod({
    required String id,
  }) async {
    try {
      final PaymentMethodModel result =
          await _baseApi.getDefaultPaymentMethod(userId: id);
      return DataSuccess<PaymentMethodModel>(result);
    } on DioError catch (e) {
      final PaymentMethodModel value = PaymentMethodModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<PaymentMethodModel>(value);
    } on Exception catch (e) {
      return DataFailed<PaymentMethodModel>(e);
    }
  }

  @override
  Future<DataState<PaymentTypeModel>> getAllPaymentType() async {
    try {
      final PaymentTypeModel result = await _baseApi.getAllPaymentType();
      return DataSuccess<PaymentTypeModel>(result);
    } on DioError catch (e) {
      final PaymentTypeModel value = PaymentTypeModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<PaymentTypeModel>(value);
    } on Exception catch (e) {
      return DataFailed<PaymentTypeModel>(e);
    }
  }

  @override
  Future<DataState<PaymentItemsModel>> getAllPaymentItem({
    required String id,
  }) async {
    try {
      final PaymentItemsModel result =
          await _baseApi.getAllPaymentMethod(userId: id);
      return DataSuccess<PaymentItemsModel>(result);
    } on DioError catch (e) {
      final PaymentItemsModel value = PaymentItemsModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<PaymentItemsModel>(value);
    } on Exception catch (e) {
      return DataFailed<PaymentItemsModel>(e);
    }
  }

  @override
  Future<DataState<PaymentMethodModel>> setDefaultPaymentMethod({
    required String userId,
    required String paymentId,
  }) async {
    try {
      PaymentMethodDefaultRequest params =
          PaymentMethodDefaultRequest(paymentTypeId: paymentId, userId: userId);
      final PaymentMethodModel result =
          await _baseApi.setDefaultPayment(request: params);
      return DataSuccess<PaymentMethodModel>(result);
    } on DioError catch (e) {
      final PaymentMethodModel value = PaymentMethodModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<PaymentMethodModel>(value);
    } on Exception catch (e) {
      return DataFailed<PaymentMethodModel>(e);
    }
  }

  @override
  Future<DataState<PaymentMethodModel>> createPaymentMethod({
    required PaymentRequestBody payload,
  }) async {
    try {
      final PaymentMethodModel result =
          await _baseApi.createPaymentMethod(bodyRequest: payload);
      return DataSuccess<PaymentMethodModel>(result);
    } on DioError catch (e) {
      final PaymentMethodModel value = PaymentMethodModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<PaymentMethodModel>(value);
    } on Exception catch (e) {
      return DataFailed<PaymentMethodModel>(e);
    }
  }

  @override
  Future<DataState<PaymentMethodModel>> editPaymentMethod({
    required String paymentId,
    required String name,
  }) async {
    try {
      PaymentMethodUpdateRequestBody payload =
          PaymentMethodUpdateRequestBody(nickname: name);
      final PaymentMethodModel result = await _baseApi.editPaymentMethod(
        id: paymentId,
        request: payload,
      );
      return DataSuccess<PaymentMethodModel>(result);
    } on DioError catch (e) {
      final PaymentMethodModel value = PaymentMethodModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<PaymentMethodModel>(value);
    } on Exception catch (e) {
      return DataFailed<PaymentMethodModel>(e);
    }
  }

  @override
  Future<DataState<PaymentMethodModel>> deletePaymentMethod({
    required String paymentId,
  }) async {
    try {
      final PaymentMethodModel result = await _baseApi.deletePaymentMethod(
        id: paymentId,
      );
      return DataSuccess<PaymentMethodModel>(result);
    } on DioError catch (e) {
      final PaymentMethodModel value = PaymentMethodModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<PaymentMethodModel>(value);
    } on Exception catch (e) {
      return DataFailed<PaymentMethodModel>(e);
    }
  }
}
