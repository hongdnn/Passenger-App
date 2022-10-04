import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/booking_page/data/model/booking_order_model.dart';
import 'package:passenger/features/booking_page/data/model/car_detail.dart';
import 'package:passenger/features/booking_page/data/model/payment_method_model.dart';
import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';
import 'package:passenger/features/booking_page/data/repo/booking_repo.dart';
import 'package:passenger/features/booking_page/data/repo/car_repo.dart';
import 'package:passenger/features/location/data/model/direction_model.dart';
import 'package:passenger/features/location/data/repo/direction_result_model.dart';
import 'package:passenger/features/location/data/repo/polyline_repo.dart';
import 'package:passenger/features/user/data/model/user.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/features/booking_page/data/model/price_by_cartype_model.dart';
import 'package:passenger/util/util.dart';

part 'booking_page_event.dart';

part 'booking_page_state.dart';

class BookingPageBloc extends Bloc<BookingPageEvent, BookingPageState> {
  BookingPageBloc(
    this._carRepo,
    this._bookingRepository,
    this._polylineRepo,
    this._userRepo,
  ) : super(const BookingPageState(listLocaleRequest: <LocationRequest>[])) {
    on<InitEvent>((InitEvent event, Emitter<BookingPageState> emitter) {
      emitter(state.copyWith(listLocaleRequest: event.listLocaleRequest));
    });
    on<GettingCarDetailEvent>(
      _handleCarDetail,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
    on<LoadingCarPriceListEvent>(
      _onLoadCarPriceList,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
    on<GetDirectionFromOriginToDestination>(
      _getDirectionFromOriginToDestination,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
    on<UpsertDraftBookingEvent>(
      _upsertBooking,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
    on<ConfirmBookingOrderEvent>(
      _confirmBookingOrder,
    );
    on<AddNewToListBooking>(_handleAddBookingList);
    on<RemoveAtListBooking>(_handleRemoveBookingList);
    on<SwapListBooking>(_handleSwapBookingList);
    on<ReOrderListBooking>(_handleReOrderBookingList);
    on<ChangeValueEvent>(_handleChangeValue);
    on<ClearStateEvent>(_clearState);
    on<ReorderListRouteEvent>(_handleReorderListRouteEvent);
  }

  final CarRepo _carRepo;
  final BookingRepository _bookingRepository;
  final PolylineRepo _polylineRepo;
  final UserRepo _userRepo;

  final List<CarDescription> listCarDescription = <CarDescription>[];

  User getCurrentUser() {
    return _userRepo.getCurrentUser();
  }

  FutureOr<void> _onLoadCarPriceList(
    LoadingCarPriceListEvent event,
    Emitter<BookingPageState> emit,
  ) async {
    emit(
      state.copyWith(
        getListCarPriceStatus: LoadState.loading,
        carPriceList: null,
      ),
    );

    final DataState<PriceByCarTypeModel> dataState = await _bookingRepository
        .getDriverList(getPriceRequestBody: event.getPriceRequestBody);

    emit(
      state.copyWith(
        getListCarPriceStatus:
            dataState.isSuccess() ? LoadState.success : LoadState.failure,
        carPriceList: dataState.isSuccess()
            ? dataState.data?.data
            : (state.carPriceList ?? dataState.data?.data),
      ),
    );
  }

  FutureOr<void> _handleCarDetail(
    GettingCarDetailEvent event,
    Emitter<BookingPageState> emitter,
  ) async {
    emitter(
      state.copyWith(
        carDescLoadState: LoadState.loading,
      ),
    );
    final DataState<CarDescription> carDes =
        await _carRepo.getCarDetail(event.carBodyRequest);
    emitter(
      state.copyWith(
        carDescLoadState:
            carDes.isSuccess() ? LoadState.success : LoadState.failure,
        carDescription: carDes.isSuccess()
            ? carDes.data
            : (state.carDescription ?? CarDescription()),
      ),
    );
  }

  Future<void> _getDirectionFromOriginToDestination(
    GetDirectionFromOriginToDestination event,
    Emitter<BookingPageState> emit,
  ) async {
    List<LocationRequest> listLocaleRequest = event.listLocaleRequest;

    List<DirectionParam> directionParams = <DirectionParam>[];

    for (int index = 0; index < listLocaleRequest.length - 1; index++) {
      if (listLocaleRequest[index].latitude != null &&
          listLocaleRequest[index].longitude != null &&
          listLocaleRequest[index + 1].latitude != null &&
          listLocaleRequest[index + 1].longitude != null) {
        directionParams.add(
          DirectionParam(
            travelMode: TravelTransportation.driving,
            start: DirectionLocation(
              lat: listLocaleRequest[index].latitude,
              lng: listLocaleRequest[index].longitude,
            ),
            end: DirectionLocation(
              lat: listLocaleRequest[index + 1].latitude,
              lng: listLocaleRequest[index + 1].longitude,
            ),
          ),
        );
      }
    }

    if (directionParams.length == listLocaleRequest.length - 1) {
      emit(
        state.copyWith(
          mapStatus: LoadState.loading,
          listRouteOptions: <TotalDirectionResultModel>[],
        ),
      );

      bool isAlternative =
          (directionParams.length == minDestinationLength - 1) &&
              event.alternatives;

      if (isAlternative) {
        DataState<List<TotalDirectionResultModel>> result =
            await _polylineRepo.getAlternativesDirectionFromOriginToDestination(
          directionParams: directionParams,
        );
        emit(
          state.copyWith(
            mapStatus:
                result.isSuccess() ? LoadState.success : LoadState.failure,
            listRouteOptions: result.isSuccess()
                ? result.data
                : <TotalDirectionResultModel>[],
          ),
        );
      } else {
        DataState<List<TotalDirectionResultModel>> result =
            await _polylineRepo.getDirectionFromOriginToDestination(
          directionParams: directionParams,
        );

        emit(
          state.copyWith(
            listRouteOptions: result.isSuccess()
                ? result.data
                : <TotalDirectionResultModel>[],
            mapStatus:
                result.isSuccess() ? LoadState.success : LoadState.failure,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          mapStatus: LoadState.failure,
          listRouteOptions: <TotalDirectionResultModel>[],
        ),
      );
    }
  }

  Future<void> _upsertBooking(
    UpsertDraftBookingEvent event,
    Emitter<BookingPageState> emitter,
  ) async {
    _polylineRepo.setPolylines(
      state.listRouteOptions[event.selectedRoute!].routeOptions,
      state.listRouteOptions[event.selectedRoute!].totalDuration,
      state.listRouteOptions[event.selectedRoute!].totalDistance,
    );

    event.body.locations = List<LocationRequest>.generate(
      event.body.locations!.length,
      (int index) => event.body.locations![index]
        ..copyWith(
          pathToLocationParams: index == 0
              ? null
              : state.listRouteOptions[event.selectedRoute!]
                  .routeOptions?[index - 1].pathToLocation,
        ),
    );

    emitter(
      state.copyWith(
        upsertBookingState: LoadState.loading,
        upsertDraftBookingModel: null,
        updateDestinationStatus: false,
      ),
    );

    final DataState<UpsertDraftBookingModel> dataState =
        await _bookingRepository.upsertDraftBooking(body: event.body);

    emitter(
      state.copyWith(
        updateDestinationStatus: false,
        upsertBookingState:
            dataState.isSuccess() ? LoadState.success : LoadState.failure,
        upsertDraftBookingModel: dataState.isSuccess()
            ? dataState.data
            : (state.upsertDraftBookingModel ?? dataState.data),
      ),
    );
  }

  Future<void> _confirmBookingOrder(
    ConfirmBookingOrderEvent event,
    Emitter<BookingPageState> emitter,
  ) async {
    emitter(
      state.copyWith(
        bookingOrderStatus: LoadState.loading,
        bookingOrderModel: null,
      ),
    );

    final DataState<BookingOrderModel> dataState =
        await _bookingRepository.createBookingOrder(body: event.body);

    emitter(
      state.copyWith(
        bookingOrderStatus:
            dataState.isSuccess() ? LoadState.success : LoadState.failure,
        bookingOrderModel: dataState.isSuccess()
            ? dataState.data
            : (state.bookingOrderModel ?? dataState.data),
      ),
    );
  }

  void _handleAddBookingList(
    AddNewToListBooking event,
    Emitter<BookingPageState> emitter,
  ) {
    List<LocationRequest> listLocaleRequest = state.listLocaleRequest;
    listLocaleRequest.add(LocationRequest());
    emitter(
      state.copyWith(
        updateDestinationStatus: true,
        listLocaleRequest: listLocaleRequest,
      ),
    );
  }

  void _handleRemoveBookingList(
    RemoveAtListBooking event,
    Emitter<BookingPageState> emitter,
  ) {
    List<LocationRequest> listLocaleRequest = state.listLocaleRequest;
    listLocaleRequest.removeAt(event.index);
    emitter(
      state.copyWith(
        updateDestinationStatus: true,
        listLocaleRequest: listLocaleRequest,
      ),
    );
  }

  void _handleSwapBookingList(
    SwapListBooking event,
    Emitter<BookingPageState> emitter,
  ) {
    List<LocationRequest> listLocaleRequest = state.listLocaleRequest;
    listLocaleRequest.swap(event.first, event.second);
    emitter(
      state.copyWith(
        updateDestinationStatus: true,
        listLocaleRequest: listLocaleRequest,
      ),
    );
  }

  void _handleReOrderBookingList(
    ReOrderListBooking event,
    Emitter<BookingPageState> emitter,
  ) {
    int newIndex = event.newIndex;
    int oldIndex = event.oldIndex;

    List<LocationRequest> listLocaleRequest = state.listLocaleRequest;
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final LocationRequest removed = listLocaleRequest.removeAt(oldIndex);
    listLocaleRequest.insert(newIndex, removed);
    emitter(
      state.copyWith(
        updateDestinationStatus: true,
        listLocaleRequest: listLocaleRequest,
      ),
    );
  }

  void _handleChangeValue(
    ChangeValueEvent event,
    Emitter<BookingPageState> emitter,
  ) {
    List<LocationRequest> listLocaleRequest = state.listLocaleRequest;
    listLocaleRequest[event.index] = event.data;
    emitter(
      state.copyWith(
        updateDestinationStatus: true,
        listLocaleRequest: listLocaleRequest,
      ),
    );
  }

  FutureOr<void> _handleReorderListRouteEvent(
    ReorderListRouteEvent event,
    Emitter<BookingPageState> emitter,
  ) async {
    List<TotalDirectionResultModel> orderedList =
        List<TotalDirectionResultModel>.from(state.listRouteOptions);
    orderedList.swap(event.swapIndex, 0);
    emitter(
      state.copyWith(
        listRouteOptions: orderedList,
      ),
    );
  }

  Future<void> _clearState(
    ClearStateEvent event,
    Emitter<BookingPageState> emitter,
  ) async {
    emitter(
      state.clear(),
    );
  }
}
