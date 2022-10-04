part of 'booking_page_bloc.dart';

class DirectionParam {
  DirectionParam({
    this.avoidFerries = true,
    this.avoidHighways = true,
    this.avoidTolls = true,
    this.optimizeWaypoints = true,
    required this.travelMode,
    required this.start,
    required this.end,
  });
  DirectionLocation start;
  DirectionLocation end;

  TravelTransportation travelMode;
  bool? avoidHighways;
  bool? avoidTolls;
  bool? avoidFerries;
  bool? optimizeWaypoints;
}

@immutable
abstract class BookingPageEvent {}

class GettingCarDetailEvent extends BookingPageEvent {
  GettingCarDetailEvent({required this.carBodyRequest});

  final CarBodyRequest carBodyRequest;
}

class LoadingCarPriceListEvent extends BookingPageEvent {
  LoadingCarPriceListEvent({required this.getPriceRequestBody});

  final GetPriceRequestBody getPriceRequestBody;
}

class GetDirectionFromOriginToDestination extends BookingPageEvent {
  GetDirectionFromOriginToDestination({
    required this.listLocaleRequest,
    this.alternatives = true,
  });

  final List<LocationRequest> listLocaleRequest;
  final bool alternatives;
}

class RequestCaptureRoute extends BookingPageEvent {
  RequestCaptureRoute();
}

class UpsertDraftBookingEvent extends BookingPageEvent {
  UpsertDraftBookingEvent({required this.body, this.selectedRoute});

  final UpsertRequestBody body;
  final int? selectedRoute;
}

class CreatePaymentMethodEvent extends BookingPageEvent {
  CreatePaymentMethodEvent(this.body);

  final PaymentRequestBody body;
}

class ConfirmBookingOrderEvent extends BookingPageEvent {
  ConfirmBookingOrderEvent(this.body);

  final ConfirmBookingRequestModel body;
}

class AddNewToListBooking extends BookingPageEvent {
  AddNewToListBooking();
}

class RemoveAtListBooking extends BookingPageEvent {
  RemoveAtListBooking({required this.index});

  final int index;
}

class SwapListBooking extends BookingPageEvent {
  SwapListBooking({required this.first, required this.second});
  final int first;
  final int second;
}

class ReOrderListBooking extends BookingPageEvent {
  ReOrderListBooking({required this.oldIndex, required this.newIndex});
  final int oldIndex;
  final int newIndex;
}

class InitEvent extends BookingPageEvent {
  InitEvent({this.listLocaleRequest});
  final List<LocationRequest>? listLocaleRequest;
}

class ChangeValueEvent extends BookingPageEvent {
  ChangeValueEvent({required this.index, required this.data});
  final int index;
  final LocationRequest data;
}

class ClearStateEvent extends BookingPageEvent {}

class ReorderListRouteEvent extends BookingPageEvent {
  ReorderListRouteEvent({required this.swapIndex});
  final int swapIndex;
}
