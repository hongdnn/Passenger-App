part of 'landing_page_bloc.dart';

class LandingPageState {
  LandingPageState({
    this.state,
    this.deviceId,
    this.bannerResponse,
    this.bannerLoadState,
    this.getBookingHistoryLoadState,
    this.getBookingHistorySortByTimeLoadState,
    this.bookingHistoryModel,
    this.bookingHistorySortByTimeModel,
    this.checkBookingAvailabilityModel,
    this.driverAcceptBookingModel,
    this.checkBookingAvailabilityStatus,
    this.driverAcceptBookingStatus,
    this.bookingStatus,
  });
  final LoadState? state;
  final LoadState? bannerLoadState;
  final LoadState? getBookingHistoryLoadState;
  final LoadState? getBookingHistorySortByTimeLoadState;
  final String? deviceId;
  final BannerResponse? bannerResponse;
  final BookingHistoryModel? bookingHistoryModel;
  final BookingHistorySortByTimeModel? bookingHistorySortByTimeModel;
  final CheckBookingAvailabilityModel? checkBookingAvailabilityModel;
  final DriverAcceptBookingModel? driverAcceptBookingModel;
  final LoadState? checkBookingAvailabilityStatus;
  final LoadState? driverAcceptBookingStatus;
  final BookingStatus? bookingStatus;

  LandingPageState copyWith({
    LoadState? state,
    LoadState? bannerLoadState,
    LoadState? getBookingHistoryLoadState,
    LoadState? getBookingHistorySortByTimeLoadState,
    String? deviceId,
    BannerResponse? bannerResponse,
    BookingHistoryModel? bookingHistoryModel,
    BookingHistorySortByTimeModel? bookingHistorySortByTimeModel,
    CheckBookingAvailabilityModel? checkBookingAvailabilityModel,
    DriverAcceptBookingModel? driverAcceptBookingModel,
    LoadState? checkBookingAvailabilityStatus,
    LoadState? driverAcceptBookingStatus,
    BookingStatus? bookingStatus,
  }) {
    return LandingPageState(
      state: state ?? this.state,
      bannerLoadState: bannerLoadState ?? this.bannerLoadState,
      getBookingHistoryLoadState:
          getBookingHistoryLoadState ?? this.getBookingHistoryLoadState,
      getBookingHistorySortByTimeLoadState:
          getBookingHistorySortByTimeLoadState ??
              this.getBookingHistorySortByTimeLoadState,
      deviceId: deviceId ?? this.deviceId,
      bannerResponse: bannerResponse ?? this.bannerResponse,
      bookingHistoryModel: bookingHistoryModel ?? this.bookingHistoryModel,
      bookingHistorySortByTimeModel:
          bookingHistorySortByTimeModel ?? this.bookingHistorySortByTimeModel,
      checkBookingAvailabilityModel:
          checkBookingAvailabilityModel ?? this.checkBookingAvailabilityModel,
      driverAcceptBookingModel:
          driverAcceptBookingModel ?? this.driverAcceptBookingModel,
      checkBookingAvailabilityStatus:
          checkBookingAvailabilityStatus ?? this.checkBookingAvailabilityStatus,
      driverAcceptBookingStatus:
          driverAcceptBookingStatus ?? this.driverAcceptBookingStatus,
      bookingStatus: bookingStatus ?? this.bookingStatus,
    );
  }
}
