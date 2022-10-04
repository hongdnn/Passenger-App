import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/booking_page/data/model/invoice_model.dart';

abstract class InvoiceRepo {
  Future<DataState<InvoiceData>> getInvoiceDetail(String invoiceId);
}
