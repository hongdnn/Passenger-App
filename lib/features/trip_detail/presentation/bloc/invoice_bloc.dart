import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/booking_page/data/model/invoice_model.dart';
import 'package:passenger/features/payment/data/repo/payment_repo.dart';
import 'package:passenger/features/trip_detail/data/repo/invoice_repo.dart';
import 'package:passenger/util/enum.dart';

part 'invoice_event.dart';
part 'invoice_state.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {
  InvoiceBloc(
    this._invoiceRepo,
    this._paymentRepo,
  ) : super(InvoiceState()) {
    on<GetInvoiceDetailEvent>(_handleGetInvoiceDetail);
    on<ProcessAndGetInvoiceEvent>(_handleProcessAndGetInvoice);
  }

  final InvoiceRepo _invoiceRepo;

  final PaymentRepo _paymentRepo;

  Future<void> _handleGetInvoiceDetail(
    GetInvoiceDetailEvent event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(state.copyWith(loadDetailInvoiceState: LoadState.loading));

    final DataState<InvoiceData> invoiceDataState =
        await _invoiceRepo.getInvoiceDetail(event.invoiceId);

    emit(
      state.copyWith(
        loadDetailInvoiceState: invoiceDataState.isSuccess()
            ? LoadState.success
            : LoadState.failure,
        currentInvoiceDetail: invoiceDataState.isSuccess()
            ? invoiceDataState.data
            : state.currentInvoiceDetail,
      ),
    );
  }

  Future<void> _handleProcessAndGetInvoice(
    ProcessAndGetInvoiceEvent event,
    Emitter<InvoiceState> emit,
  ) async {
    emit(state.copyWith(loadDetailInvoiceState: LoadState.loading));

    final DataState<void> processDataState =
        await _paymentRepo.processInvoice(id: event.invoiceId);

    if (processDataState.isError()) {
      emit(
        state.copyWith(
          currentInvoiceDetail: state.currentInvoiceDetail,
          processInvoiceStatus: LoadState.failure,
        ),
      );
    } else {
      final DataState<InvoiceData> invoiceDataState =
          await _invoiceRepo.getInvoiceDetail(event.invoiceId);

      emit(
        state.copyWith(
          loadDetailInvoiceState: invoiceDataState.isSuccess()
              ? LoadState.success
              : LoadState.failure,
          currentInvoiceDetail:
              invoiceDataState.isSuccess() ? invoiceDataState.data : null,
          processInvoiceStatus: invoiceDataState.isSuccess()
              ? LoadState.success
              : LoadState.failure,
        ),
      );
    }
  }
}
