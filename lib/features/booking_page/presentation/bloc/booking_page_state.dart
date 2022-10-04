part of 'booking_page_bloc.dart';

class BookingPageState {
  const BookingPageState({
    this.status = BookingPageStatus.init,
    this.carPriceList,
    this.carDescLoadState = LoadState.none,
    this.carDescription,
    this.shouldCapture,
    this.mapStatus = LoadState.none,
    this.upsertDraftBookingModel,
    this.upsertBookingState,
    this.paymentMethodModel,
    this.bookingOrderModel,
    this.getListCarPriceStatus = LoadState.none,
    this.bookingOrderStatus,
    this.updateDestinationStatus,
    required this.listLocaleRequest,
    this.listRouteOptions = const <TotalDirectionResultModel>[],
    this.idDriverBooking,
  });

  final LoadState? mapStatus;
  final BookingPageStatus status;
  final List<PriceByCarTypeData>? carPriceList;
  final LoadState? carDescLoadState;
  final CarDescription? carDescription;
  final bool? shouldCapture;
  final LoadState? upsertBookingState;
  final UpsertDraftBookingModel? upsertDraftBookingModel;
  final PaymentMethodModel? paymentMethodModel;
  final BookingOrderModel? bookingOrderModel;
  final LoadState? getListCarPriceStatus;
  final LoadState? bookingOrderStatus;
  final bool? updateDestinationStatus;
  final List<LocationRequest> listLocaleRequest;
  final List<TotalDirectionResultModel> listRouteOptions;
  final String? idDriverBooking;

  BookingPageState copyWith({
    BookingPageStatus? status,
    List<PriceByCarTypeData>? carPriceList,
    CarDescription? carDescription,
    LoadState? carDescLoadState,
    bool? shouldCapture,
    LoadState? mapStatus,
    UpsertDraftBookingModel? upsertDraftBookingModel,
    LoadState? upsertBookingState,
    PaymentMethodModel? paymentMethodModel,
    BookingOrderModel? bookingOrderModel,
    LoadState? getListCarPriceStatus,
    LoadState? bookingOrderStatus,
    bool? updateDestinationStatus,
    List<LocationRequest>? listLocaleRequest,
    List<TotalDirectionResultModel>? listRouteOptions,
    String? idDriverBooking,
  }) {
    return BookingPageState(
      status: status ?? this.status,
      carPriceList: carPriceList ?? this.carPriceList,
      carDescription: carDescription ?? this.carDescription,
      carDescLoadState: carDescLoadState ?? this.carDescLoadState,
      shouldCapture: shouldCapture ?? false,
      mapStatus: mapStatus ?? this.mapStatus,
      upsertDraftBookingModel:
          upsertDraftBookingModel ?? this.upsertDraftBookingModel,
      upsertBookingState: upsertBookingState ?? this.upsertBookingState,
      paymentMethodModel: paymentMethodModel ?? this.paymentMethodModel,
      bookingOrderModel: bookingOrderModel ?? this.bookingOrderModel,
      getListCarPriceStatus:
          getListCarPriceStatus ?? this.getListCarPriceStatus,
      bookingOrderStatus: bookingOrderStatus ?? this.bookingOrderStatus,
      updateDestinationStatus: updateDestinationStatus ?? false,
      listLocaleRequest: listLocaleRequest ?? this.listLocaleRequest,
      listRouteOptions: listRouteOptions ?? this.listRouteOptions,
      idDriverBooking: idDriverBooking ?? this.idDriverBooking,
    );
  }

  BookingPageState clear() {
    return const BookingPageState(listLocaleRequest: <LocationRequest>[]);
  }
}
