part of 'invoice_bloc.dart';

@immutable
abstract class InvoiceEvent {}

class GetInvoiceDetailEvent extends InvoiceEvent {
  GetInvoiceDetailEvent({required this.invoiceId});
  final String invoiceId;
}

class ProcessAndGetInvoiceEvent extends InvoiceEvent {
  ProcessAndGetInvoiceEvent({  
    required this.invoiceId,
  });
  final String invoiceId;

}