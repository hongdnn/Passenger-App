import 'package:dio/dio.dart';
import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/landing_page/data/model/booking_detail_model.dart';
import 'package:passenger/features/payment/data/model/update_booking_model.dart';
import 'package:passenger/features/payment/data/repo/payment_repo.dart';

import '../../../booking_page/data/model/invoice_model.dart';

class PaymentRepoImpl implements PaymentRepo {
  PaymentRepoImpl(this._baseApi);

  final RhBaseApi _baseApi;

  @override
  Future<DataState<InvoiceModel>> createInvoice({
    required InvoiceRequestBody body,
  }) async {
    try {
      final InvoiceModel result =
          await _baseApi.createInvoice(bodyRequest: body);
      return DataSuccess<InvoiceModel>(result);
    } on DioError catch (e) {
      final InvoiceModel value = InvoiceModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<InvoiceModel>(value);
    } on Exception catch (e) {
      return DataFailed<InvoiceModel>(e);
    }
  }

  @override
  Future<DataState<void>> processInvoice({required String id}) async {
    try {
      await _baseApi.processInvoice(id: id);
      return const DataSuccess<void>(null);
    } on Exception catch (e) {
      return DataFailed<void>(e);
    }
  }

  @override
  Future<DataState<BookingDetailModel>> updatePaymentInvoice({
    required String bookingId,
    required UpdateBookingPayloadModel payload,
  }) async {
    try {
      final BookingDetailModel result =
          await _baseApi.updateBooking(id: bookingId, request: payload);
      return DataSuccess<BookingDetailModel>(result);
    } on DioError catch (e) {
      final BookingDetailModel value = BookingDetailModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<BookingDetailModel>(value);
    } on Exception catch (e) {
      return DataFailed<BookingDetailModel>(e);
    }
  }

  @override
  Future<DataState<InvoiceModel>> getInvoiceByBookingId({
    required String id,
  }) async {
    try {
      final InvoiceModel result = await _baseApi.getInvoiceByBookingId(id: id);
      return DataSuccess<InvoiceModel>(result);
    } on DioError catch (e) {
      final InvoiceModel value = InvoiceModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<InvoiceModel>(value);
    } on Exception catch (e) {
      return DataFailed<InvoiceModel>(e);
    }
  }
}
