part of 'cancel_booking_bloc.dart';

@immutable
abstract class CancelBookingEvent {}

class SelectReasonEvent extends CancelBookingEvent {
  SelectReasonEvent(this.idReason);

  final int idReason;
}

class ConfirmCancelBookingEvent extends CancelBookingEvent {
  ConfirmCancelBookingEvent({
    required this.cancelBookingBody,
  });
  final CancelBookingBody cancelBookingBody;
}
