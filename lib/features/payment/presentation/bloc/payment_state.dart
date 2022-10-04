part of 'payment_bloc.dart';

class PaymentState {
  PaymentState({
    this.createInvoiceStatus,
    this.invoiceModel,
    this.processInvoiceStatus,
    this.updatePaymentBookingStatus,
  });

  final LoadState? createInvoiceStatus;
  final LoadState? updatePaymentBookingStatus;
  final InvoiceModel? invoiceModel;
  final LoadState? processInvoiceStatus;

  PaymentState copyWith({
    LoadState? invoiceStatus,
    InvoiceModel? invoiceModel,
    LoadState? processInvoiceStatus,
    LoadState? updatePaymentBookingStatus,
    LoadState? createInvoiceStatus,
  }) {
    return PaymentState(
      createInvoiceStatus: invoiceStatus ?? this.createInvoiceStatus,
      invoiceModel: invoiceModel ?? this.invoiceModel,
      processInvoiceStatus: processInvoiceStatus ?? this.processInvoiceStatus,
      updatePaymentBookingStatus:
          updatePaymentBookingStatus ?? this.updatePaymentBookingStatus,
    );
  }
}
