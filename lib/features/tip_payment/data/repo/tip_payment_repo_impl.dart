import 'package:dio/dio.dart';
import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/tip_payment/data/model/request/tip_payment_invoice_req.dart';
import 'package:passenger/features/tip_payment/data/model/response/tip_payment_invoice.dart';
import 'package:passenger/features/tip_payment/data/repo/tip_payment_repo.dart';

class TipPaymentRepoImpl extends TipPaymentRepo {
  TipPaymentRepoImpl(this._baseApi);

  final RhBaseApi _baseApi;

  @override
  Future<DataState<TipPaymentInvoice>> upsertTipPaymentInvoice(
    TipPaymentInvoiceRequest reqBody,
  ) async {
    try {
      final TipPaymentInvoiceResponse result =
          await _baseApi.upsertTipPaymentInvoice(
        reqBody: reqBody,
      );
      return DataSuccess<TipPaymentInvoice>(result.data!);
    } on DioError catch (e) {
      final TipPaymentInvoice value = TipPaymentInvoice.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<TipPaymentInvoice>(value);
    } on Exception catch (e) {
      return DataFailed<TipPaymentInvoice>(e);
    }
  }

  @override
  Future<DataState<TipPaymentInvoice>> processTipPaymentInvoice(
    TipPaymentInvoiceProcessRequest processRequest,
  ) async {
    try {
      final TipPaymentInvoiceResponse result =
          await _baseApi.processTipPaymentInvoice(
        processRequest: processRequest,
      );
      return DataSuccess<TipPaymentInvoice>(result.data!);
    } on DioError catch (e) {
      final TipPaymentInvoice value = TipPaymentInvoice.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<TipPaymentInvoice>(value);
    } on Exception catch (e) {
      return DataFailed<TipPaymentInvoice>(e);
    }
  }
}
