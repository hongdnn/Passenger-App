part of 'tip_payment_bloc.dart';

class TipPaymentState {
  TipPaymentState({
    this.refreshTipPaymentInvoiceState,
    this.tipPaymentInvoice,
    this.processTipPaymentInvoiceState,
  });

  final LoadState? refreshTipPaymentInvoiceState;
  final TipPaymentInvoice? tipPaymentInvoice;
  final LoadState? processTipPaymentInvoiceState;

  TipPaymentState copyWith({
    LoadState? refreshTipPaymentInvoiceState,
    TipPaymentInvoice? tipPaymentInvoice,
    LoadState? processTipPaymentInvoiceState,
  }) {
    return TipPaymentState(
      refreshTipPaymentInvoiceState:
          refreshTipPaymentInvoiceState ?? this.refreshTipPaymentInvoiceState,
      tipPaymentInvoice: tipPaymentInvoice ?? this.tipPaymentInvoice,
      processTipPaymentInvoiceState:
          processTipPaymentInvoiceState ?? this.processTipPaymentInvoiceState,
    );
  }

  TipPaymentState clear() {
    return TipPaymentState();
  }
}
