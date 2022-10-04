part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent {}

class GetInvoiceByIdBookingEvent extends PaymentEvent {
  GetInvoiceByIdBookingEvent(this.body);

  final InvoiceRequestBody body;
}

class ProcessInvoiceEvent extends PaymentEvent {
  ProcessInvoiceEvent(this.id);

  final String id;
}

class UpdateBookingEvent extends PaymentEvent {
  UpdateBookingEvent(this.bookingId, this.payload);

  final String bookingId;
  final UpdateBookingPayloadModel payload;
}
