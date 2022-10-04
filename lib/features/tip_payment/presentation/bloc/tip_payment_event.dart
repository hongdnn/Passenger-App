part of 'tip_payment_bloc.dart';

@immutable
abstract class TipPaymentEvent {}

class UpsertTipPaymentInvoiceEvent extends TipPaymentEvent {
  UpsertTipPaymentInvoiceEvent(this.reqBody);
  final TipPaymentInvoiceRequest reqBody;
}

class ProcessTipPaymentInvoiceEvent extends TipPaymentEvent {
  ProcessTipPaymentInvoiceEvent(this.tipInvoiceId);
  final String tipInvoiceId;
}

class ClearStateEvent extends TipPaymentEvent {}
