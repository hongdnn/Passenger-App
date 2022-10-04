import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/tip_payment/data/model/request/tip_payment_invoice_req.dart';
import 'package:passenger/features/tip_payment/data/model/response/tip_payment_invoice.dart';
import 'package:passenger/features/tip_payment/data/repo/tip_payment_repo.dart';
import 'package:passenger/features/user/data/model/user.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/util/enum.dart';

part 'tip_payment_event.dart';
part 'tip_payment_state.dart';

class TipPaymentBloc extends Bloc<TipPaymentEvent, TipPaymentState> {
  TipPaymentBloc(
    this._tipPaymentRepo,
    this.userRepo,
  ) : super(TipPaymentState()) {
    on<UpsertTipPaymentInvoiceEvent>(_handleUpsertTipPaymentInvoice);
    on<ProcessTipPaymentInvoiceEvent>(_handleProcessTipPaymentInvoice);
    on<ClearStateEvent>(_clearState);
  }

  final TipPaymentRepo _tipPaymentRepo;
  final UserRepo userRepo;

  User getCurrentUser() {
    return userRepo.getCurrentUser();
  }

  String? getTipInvoiceId() {
    return state.tipPaymentInvoice?.id;
  }

  Future<void> _handleUpsertTipPaymentInvoice(
    UpsertTipPaymentInvoiceEvent event,
    Emitter<TipPaymentState> emit,
  ) async {
    emit(
      state.copyWith(
        refreshTipPaymentInvoiceState: LoadState.loading,
      ),
    );
    TipPaymentInvoiceRequest reqBody = event.reqBody;
    reqBody = reqBody.copyWith(
      userIdParam: getCurrentUser().id,
    );
    final DataState<TipPaymentInvoice> dataState =
        await _tipPaymentRepo.upsertTipPaymentInvoice(event.reqBody);
    emit(
      state.copyWith(
        refreshTipPaymentInvoiceState:
            dataState.isSuccess() ? LoadState.success : LoadState.failure,
        tipPaymentInvoice: dataState.data,
      ),
    );
  }

  Future<void> _handleProcessTipPaymentInvoice(
    ProcessTipPaymentInvoiceEvent event,
    Emitter<TipPaymentState> emit,
  ) async {
    emit(
      state.copyWith(
        processTipPaymentInvoiceState: LoadState.loading,
      ),
    );

    final DataState<TipPaymentInvoice> dataState =
        await _tipPaymentRepo.processTipPaymentInvoice(
      TipPaymentInvoiceProcessRequest(
        tipInvoiceId: event.tipInvoiceId,
      ),
    );
    emit(
      state.copyWith(
        processTipPaymentInvoiceState:
            dataState.isSuccess() ? LoadState.success : LoadState.failure,
      ),
    );
  }

  Future<void> _clearState(
    ClearStateEvent event,
    Emitter<TipPaymentState> emitter,
  ) async {
    emitter(
      state.clear(),
    );
  }
}
