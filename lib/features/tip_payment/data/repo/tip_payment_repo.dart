import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/tip_payment/data/model/request/tip_payment_invoice_req.dart';
import 'package:passenger/features/tip_payment/data/model/response/tip_payment_invoice.dart';

abstract class TipPaymentRepo {
  Future<DataState<TipPaymentInvoice>> upsertTipPaymentInvoice(
    TipPaymentInvoiceRequest reqBody,
  );

  Future<DataState<TipPaymentInvoice>> processTipPaymentInvoice(
    TipPaymentInvoiceProcessRequest processRequest,
  );
}
