part of 'invoice_bloc.dart';

class InvoiceState {
  InvoiceState({
    this.loadDetailInvoiceState = LoadState.none,
    this.currentInvoiceDetail,
    this.processInvoiceStatus,
  });

  final LoadState? loadDetailInvoiceState;
  final InvoiceData? currentInvoiceDetail;
  final LoadState? processInvoiceStatus;

  InvoiceState copyWith({
    LoadState? loadDetailInvoiceState,
    InvoiceData? currentInvoiceDetail,
    LoadState? processInvoiceStatus,
  }) {
    return InvoiceState(
      loadDetailInvoiceState:
          loadDetailInvoiceState ?? this.loadDetailInvoiceState,
      currentInvoiceDetail: currentInvoiceDetail ?? this.currentInvoiceDetail,
      processInvoiceStatus: processInvoiceStatus ?? this.processInvoiceStatus,
    );
  }
}
