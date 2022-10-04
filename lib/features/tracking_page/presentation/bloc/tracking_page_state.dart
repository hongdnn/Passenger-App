part of 'tracking_page_bloc.dart';

class TrackingPageState {
  TrackingPageState({
    this.acceptBookingState,
    this.driverAcceptBookingModel,
    this.confirmPickupPassengerState,
    this.confirmPickupPassengerModel,
    this.finishTripState,
    this.bookingStatus,
    this.bookingDriverStatus,
    this.finishTripModel,
    this.searchDriverBookingStatus,
    this.idDriverBooking,
    this.cancelBookingNotDriver,
    this.errorMessage,
  });

  final LoadState? acceptBookingState;
  final DriverAcceptBookingModel? driverAcceptBookingModel;
  final LoadState? confirmPickupPassengerState;
  final ConfirmPickupPassengerModel? confirmPickupPassengerModel;
  final LoadState? finishTripState;
  final BookingStatus? bookingStatus;
  final BookingDriverStatus? bookingDriverStatus;
  final FinishTripModel? finishTripModel;
  final LoadState? searchDriverBookingStatus;
  final String? idDriverBooking;
  final LoadState? cancelBookingNotDriver;
  final String? errorMessage;

  TrackingPageState copyWith({
    LoadState? acceptBookingState,
    DriverAcceptBookingModel? driverAcceptBookingModel,
    LoadState? confirmPickupPassengerState,
    ConfirmPickupPassengerModel? confirmPickupPassengerModel,
    LoadState? finishTripState,
    BookingStatus? bookingStatus,
    BookingDriverStatus? bookingDriverStatus,
    FinishTripModel? finishTripModel,
    LoadState? searchDriverBookingStatus,
    String? idDriverBooking,
    LoadState? cancelBookingNotDriver,
    String? errorMessage,
  }) {
    return TrackingPageState(
      acceptBookingState: acceptBookingState ?? this.acceptBookingState,
      driverAcceptBookingModel:
          driverAcceptBookingModel ?? this.driverAcceptBookingModel,
      confirmPickupPassengerState:
          confirmPickupPassengerState ?? this.confirmPickupPassengerState,
      confirmPickupPassengerModel:
          confirmPickupPassengerModel ?? this.confirmPickupPassengerModel,
      finishTripState: finishTripState ?? this.finishTripState,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      bookingDriverStatus: bookingDriverStatus ?? this.bookingDriverStatus,
      finishTripModel: finishTripModel ?? this.finishTripModel,
      searchDriverBookingStatus:
          searchDriverBookingStatus ?? this.searchDriverBookingStatus,
      idDriverBooking: idDriverBooking ?? this.idDriverBooking,
      cancelBookingNotDriver:
          cancelBookingNotDriver ?? this.cancelBookingNotDriver,
      errorMessage:
          errorMessage ?? this.errorMessage,
    );
  }

  TrackingPageState clear() {
    return TrackingPageState();
  }
}
