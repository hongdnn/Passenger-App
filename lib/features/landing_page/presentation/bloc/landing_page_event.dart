part of 'landing_page_bloc.dart';

abstract class LandingPageEvent {}

class InitializeLandingEvent extends LandingPageEvent {}

class GetDraftBookingEvent extends LandingPageEvent {
  GetDraftBookingEvent();
}

class GetBannerEvent extends LandingPageEvent {}

class GetBookingHistoryEvent extends LandingPageEvent {
  GetBookingHistoryEvent(this.limit);

  final int limit;
}

class GetBookingHistorySortByTimeEvent extends LandingPageEvent {
  GetBookingHistorySortByTimeEvent(this.limit);

  final int limit;
}

class SetLikeForBookingEvent extends LandingPageEvent {
  SetLikeForBookingEvent(this.requestBody, this.id);

  final LikeRequestModel requestBody;
  final String id;
}

class RefreshAllDataEvent extends LandingPageEvent {}

class CheckBookingAvailabilityEvent extends LandingPageEvent {
  CheckBookingAvailabilityEvent();
}

class GetBookingByIdEvent extends LandingPageEvent {
  GetBookingByIdEvent(this.id);

  final String id;
}

class ClearDataLandingEvent extends LandingPageEvent {}

class UpdateStatusBookingEvent extends LandingPageEvent {
  UpdateStatusBookingEvent(this.bookingStatus);

  final BookingStatus bookingStatus;
}
