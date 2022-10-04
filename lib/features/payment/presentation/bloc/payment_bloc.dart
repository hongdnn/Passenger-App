import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/booking_page/data/model/invoice_model.dart';
import 'package:passenger/features/landing_page/data/model/booking_detail_model.dart';
import 'package:passenger/features/payment/data/repo/payment_repo.dart';
import 'package:passenger/features/user/data/model/user.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/util/enum.dart';

import '../../data/model/update_booking_model.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc(this._paymentRepo, this.userRepo) : super(PaymentState()) {
    on<GetInvoiceByIdBookingEvent>(
      _getInvoiceByIdBooking,
    );
    on<ProcessInvoiceEvent>(_processInvoice);
    on<UpdateBookingEvent>(_updateBookingPayment);
  }

  final PaymentRepo _paymentRepo;
  final UserRepo userRepo;

  User getCurrentUser() {
    return userRepo.getCurrentUser();
  }

  Future<void> _getInvoiceByIdBooking(
    GetInvoiceByIdBookingEvent event,
    Emitter<PaymentState> emitter,
  ) async {
    emitter(
      state.copyWith(
        invoiceStatus: LoadState.loading,
        invoiceModel: null,
      ),
    );
    final DataState<InvoiceModel> dataState = await _paymentRepo
        .getInvoiceByBookingId(id: event.body.bookingId ?? '');

    emitter(
      state.copyWith(
        invoiceStatus:
            dataState.isSuccess() ? LoadState.success : LoadState.failure,
        invoiceModel: dataState.data,
      ),
    );
  }

  Future<void> _processInvoice(
    ProcessInvoiceEvent event,
    Emitter<PaymentState> emitter,
  ) async {
    emitter(
      state.copyWith(
        processInvoiceStatus: LoadState.loading,
      ),
    );

    final DataState<void> dataState =
        await _paymentRepo.processInvoice(id: event.id);

    emitter(
      state.copyWith(
        processInvoiceStatus:
            dataState.isSuccess() ? LoadState.success : LoadState.failure,
      ),
    );
  }

  Future<void> _updateBookingPayment(
    UpdateBookingEvent event,
    Emitter<PaymentState> emitter,
  ) async {
    emitter(
      state.copyWith(
        updatePaymentBookingStatus: LoadState.loading,
      ),
    );
    final DataState<BookingDetailModel> dataState =
        await _paymentRepo.updatePaymentInvoice(
      bookingId: event.bookingId,
      payload: event.payload,
    );
    InvoiceModel? currentInvoice = state.invoiceModel;
    if (dataState.isSuccess()) {
      currentInvoice?.data?.booking = dataState.data?.data;
    }
    emitter(
      state.copyWith(
        updatePaymentBookingStatus:
            dataState.isSuccess() ? LoadState.success : LoadState.failure,
        invoiceModel: currentInvoice,
      ),
    );
  }
}
