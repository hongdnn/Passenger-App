import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/booking_page/data/model/invoice_model.dart';
import 'package:passenger/features/landing_page/data/model/booking_detail_model.dart';
import 'package:passenger/features/payment/data/model/update_booking_model.dart';

abstract class PaymentRepo {
  Future<DataState<InvoiceModel>> createInvoice({
    required InvoiceRequestBody body,
  });
  Future<DataState<void>> processInvoice({
    required String id,
  });
  Future<DataState<BookingDetailModel>> updatePaymentInvoice({
    required String bookingId,
    required UpdateBookingPayloadModel payload,
  });

  Future<DataState<InvoiceModel>> getInvoiceByBookingId({
    required String id,
  });
}
