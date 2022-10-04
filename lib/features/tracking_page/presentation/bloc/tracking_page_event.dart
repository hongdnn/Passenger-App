part of 'tracking_page_bloc.dart';

@immutable
abstract class TrackingPageEvent {}

// class AcceptBookingEvent implements TrackingPageEvent {
//   AcceptBookingEvent({required this.id, required this.body});

//   final String id;
//   final DriverAcceptBookingRequestBody body;
// }

class ConfirmPickupPassengerEvent implements TrackingPageEvent {
  ConfirmPickupPassengerEvent({required this.body});

  final ConfirmPickupPassengerRequestBody body;
}

class FinishTripEvent implements TrackingPageEvent {
  FinishTripEvent({required this.body});

  final FinishTripRequestBody body;
}

class ClearDataEvent implements TrackingPageEvent {}

class ListenNotification implements TrackingPageEvent {}

class UpdateStatusBookingEvent implements TrackingPageEvent {
  UpdateStatusBookingEvent(this.bookingStatus);

  final BookingStatus bookingStatus;
}

class GetBookingInfoByIdEvent implements TrackingPageEvent {
  GetBookingInfoByIdEvent(this.idBooking);

  final String idBooking;
}

class AcceptBookingDriverAppEvent implements TrackingPageEvent {
  AcceptBookingDriverAppEvent(this.driverBookingId);

  final String driverBookingId;
}

class CancelBookingDriverAppEvent implements TrackingPageEvent {
  CancelBookingDriverAppEvent(this.driverBookingId);

  final String driverBookingId;
}

class ConfirmPickUpPassengerDriverAppEvent implements TrackingPageEvent {
  ConfirmPickUpPassengerDriverAppEvent(this.driverBookingId);

  final String driverBookingId;
}

class FinishTripDriverAppEvent implements TrackingPageEvent {
  FinishTripDriverAppEvent(this.driverBookingId);

  final String driverBookingId;
}

class AlmostArriveDriverAppEvent implements TrackingPageEvent {
  AlmostArriveDriverAppEvent(this.driverBookingId);

  final String driverBookingId;
}

class ArrivePickUpToDriverAppDriverAppEvent implements TrackingPageEvent {
  ArrivePickUpToDriverAppDriverAppEvent(this.driverBookingId);

  final String driverBookingId;
}

class ReSearchBookingEvent implements TrackingPageEvent {
  ReSearchBookingEvent();
}

class SearchDriverForBookingEvent implements TrackingPageEvent {
  SearchDriverForBookingEvent(this.idBooking);
  final String idBooking;
}

class CancelBookingNotDriverEvent implements TrackingPageEvent {
  CancelBookingNotDriverEvent(this.cancelBookingBody);
  final CancelBookingBody cancelBookingBody;
}
