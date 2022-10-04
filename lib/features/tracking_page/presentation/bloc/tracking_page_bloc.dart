import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:passenger/core/app_config/get_it/getit_config.dart';
import 'package:passenger/core/app_config/notification/config_notification.dart';
import 'package:passenger/core/app_config/notification/data_notification_model.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/booking_page/data/model/cancel_booking_model.dart';
import 'package:passenger/features/booking_page/data/model/search_driver_for_booking_model.dart';
import 'package:passenger/features/booking_page/data/repo/booking_repo.dart';
import 'package:passenger/features/landing_page/data/repo/booking_availability_repo.dart';
import 'package:passenger/features/location/data/repo/direction_result_model.dart';
import 'package:passenger/features/location/data/repo/polyline_repo.dart';
import 'package:passenger/features/tracking_page/data/model/accept_booking_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/almost_arrive_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/arrive_to_pick_up_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/cancel_booking_driver_model.dart';
import 'package:passenger/features/tracking_page/data/model/confirm_pick_up_passenger_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/confirm_pickup_passenger_model.dart';
import 'package:passenger/features/tracking_page/data/model/driver_accept_booking_model.dart';
import 'package:passenger/features/tracking_page/data/model/finish_trip_driver_app_model.dart';
import 'package:passenger/features/tracking_page/data/model/finish_trip_model.dart';
import 'package:passenger/features/tracking_page/data/repo/tracking_page_repo.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/util.dart';

part 'tracking_page_event.dart';
part 'tracking_page_state.dart';

class TrackingPageBloc extends Bloc<TrackingPageEvent, TrackingPageState> {
  TrackingPageBloc(
    this._trackingPageRepo,
    this._polylineRepo,
    this._bookingAvailabilityRepo,
    this._bookingRepository,
  ) : super(TrackingPageState(bookingStatus: BookingStatus.searching)) {
    _listenNotification();
    on<AcceptBookingDriverAppEvent>(
      _acceptBookingDriverApp,
      transformer: debounce(const Duration(milliseconds: 2000)),
    );
    on<ConfirmPickupPassengerEvent>(_confirmPickupPassenger);
    on<FinishTripEvent>(_finishTrip);
    on<ClearDataEvent>(_clearDataWhenFinish);
    on<UpdateStatusBookingEvent>(_updateStatusBookingEvent);
    on<GetBookingInfoByIdEvent>(_getBookingByIdEvent);
    on<CancelBookingDriverAppEvent>(_cancelBookingDriverAppEvent);
    on<ConfirmPickUpPassengerDriverAppEvent>(_confirmPickUpPassengerDriverApp);
    on<FinishTripDriverAppEvent>(_finishTripDriverApp);
    on<AlmostArriveDriverAppEvent>(_almostArriveDriverAppEvent);
    on<ArrivePickUpToDriverAppDriverAppEvent>(
      _arrivePickUpToDriverAppDriverAppEvent,
    );
    on<ReSearchBookingEvent>(
      _reSearchBookingEvent,
    );
    on<SearchDriverForBookingEvent>(
      _searchDriverForBookingEvent,
    );
    on<CancelBookingNotDriverEvent>(
      _cancelBookingNotDriverEvent,
    );
  }

  final TrackingPageRepo _trackingPageRepo;

  final PolylineRepo _polylineRepo;

  final BookingAvailabilityRepo _bookingAvailabilityRepo;
  final BookingRepository _bookingRepository;

  List<DirectionResultModel>? get getLatestPolylineList =>
      _polylineRepo.getLatestPolylineList();

  double? get getDistance => _polylineRepo.getDistance();

  double? get getDuration => _polylineRepo.getDuration();
  String? idDriverBooking;
  String? _idBooking;

  Future<void> _searchDriverForBookingEvent(
    SearchDriverForBookingEvent event,
    Emitter<TrackingPageState> emitter,
  ) async {
    log('_searchDriverForBookingEvent');
    final DataState<SearchDriverForBookingModel> dataState =
        await _trackingPageRepo.searchDriverForBooking(
      body: SearchDriverForBookingResponse(bookingId: event.idBooking),
    );
    // if (dataState.isSuccess()) {
    //   idDriverBooking = dataState.data?.data?.driverAppBookingId ?? '';
    // }

    emitter(
      state.copyWith(
        searchDriverBookingStatus:
            dataState.isSuccess() ? LoadState.success : LoadState.failure,
        idDriverBooking: dataState.isSuccess()
            ? dataState.data?.data?.driverAppBookingId ?? ''
            : '',
        errorMessage: dataState.isError() ? dataState.data?.errorMessage : '',
        bookingStatus: BookingStatus.searching,
      ),
    );
  }

  Future<void> _cancelBookingNotDriverEvent(
    CancelBookingNotDriverEvent event,
    Emitter<TrackingPageState> emitter,
  ) async {
    log('_cancelBookingEvent');
    emitter(
      state.copyWith(cancelBookingNotDriver: LoadState.loading),
    );
    DataState<CancelBookingModel> cancelBookingModel =
        await _bookingRepository.cancelBookingOrder(
      body: event.cancelBookingBody,
    );

    emitter(
      state.copyWith(
        cancelBookingNotDriver: cancelBookingModel.isSuccess()
            ? LoadState.success
            : LoadState.failure,
      ),
    );
  }

  BookingStatus getBookingStatus({required String status}) {
    BookingStatus? bookingStatus;

    bookingStatus = BookingStatus.values
        .where(
          (BookingStatus element) => element.value.toString() == status,
        )
        .toList()
        .first;
    log('bookingStatus:$bookingStatus');
    return bookingStatus;
  }

  Future<void> _getBookingByIdEvent(
    GetBookingInfoByIdEvent event,
    Emitter<TrackingPageState> emit,
  ) async {
    log('_getBookingByIdEvent');

    emit(
      state.copyWith(
        driverAcceptBookingModel: null,
      ),
    );

    final DataState<DriverAcceptBookingModel> model =
        await _bookingAvailabilityRepo.getBookingAvailabilityInfo(
      event.idBooking,
    );
    int? status;
    log('_getBookingByIdEvent:@${model.isSuccess()}');

    if (model.isSuccess()) {
      idDriverBooking = model.data?.data?.driverAppBookingId ?? '';
      log('idDriverBooking:$idDriverBooking');
      status = model.data?.data?.status;
    }

    emit(
      state.copyWith(
        errorMessage: model.isError() ? model.data?.errorMessage : '',
        bookingStatus: getBookingStatus(status: (status ?? 0).toString()),
        driverAcceptBookingModel: model.isSuccess()
            ? model.data
            : (state.driverAcceptBookingModel ?? model.data),
      ),
    );
  }

  Future<void> _acceptBookingDriverApp(
    AcceptBookingDriverAppEvent event,
    Emitter<TrackingPageState> emitter,
  ) async {
    log('_acceptBookingDriverApp');
    emitter(
      state.copyWith(
        acceptBookingState: LoadState.loading,
        driverAcceptBookingModel: null,
      ),
    );

    final DataState<AcceptBookingDriverAppModel> dataState =
        await _trackingPageRepo.acceptBookingDriverApp(
      driverBookingId: event.driverBookingId,
    );
    if (dataState.isSuccess()) {
      Clipboard.setData(
        ClipboardData(text: event.driverBookingId),
      );
    }

    emitter(
      state.copyWith(
        acceptBookingState:
            dataState.isSuccess() ? LoadState.success : LoadState.failure,
        errorMessage: dataState.isError() ? dataState.data?.errorMessage : '',
      ),
    );
  }

  Future<void> _confirmPickupPassenger(
    ConfirmPickupPassengerEvent event,
    Emitter<TrackingPageState> emitter,
  ) async {
    emitter(
      state.copyWith(
        confirmPickupPassengerState: LoadState.loading,
        confirmPickupPassengerModel: null,
      ),
    );

    final DataState<ConfirmPickupPassengerModel> dataState =
        await _trackingPageRepo.confirmPickup(body: event.body);

    emitter(
      state.copyWith(
        confirmPickupPassengerState:
            dataState.isSuccess() ? LoadState.success : LoadState.failure,
        bookingStatus: BookingStatus.driverPickUp,
        confirmPickupPassengerModel: dataState.isSuccess()
            ? dataState.data
            : (state.confirmPickupPassengerModel ?? dataState.data),
      ),
    );
  }

  Future<void> _finishTrip(
    FinishTripEvent event,
    Emitter<TrackingPageState> emitter,
  ) async {
    emitter(
      state.copyWith(
        finishTripState: LoadState.loading,
        finishTripModel: null,
      ),
    );

    final DataState<FinishTripModel> dataState =
        await _trackingPageRepo.finishTrip(body: event.body);

    emitter(
      state.copyWith(
        finishTripState:
            dataState.isSuccess() ? LoadState.success : LoadState.failure,
        bookingStatus: BookingStatus.completed,
        finishTripModel: dataState.isSuccess()
            ? dataState.data
            : (state.finishTripModel ?? dataState.data),
      ),
    );
  }

  Future<void> _clearDataWhenFinish(
    ClearDataEvent event,
    Emitter<TrackingPageState> emitter,
  ) async {
    emitter(state.clear());
  }

  FutureOr<void> _listenNotification() async {
    log('_listenNotification');

    BookingStatus? bookingStatus;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      DataNotificationModel dataNotificationModel =
          DataNotificationModel.fromJson(message.data);
      log('onMessage:${jsonEncode(dataNotificationModel)}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        log('''dataNotificationModel.actionCode:${dataNotificationModel.actionCode}''');
        getIt<ConfigNotification>().flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  color: Colors.blue,
                  playSound: true,
                  showProgress: true,
                  priority: Priority.high,
                  icon: '@mipmap/ic_launcher',
                ),
              ),
            );
      } else {
        log('notification != null && android != null');
      }
      bookingStatus = BookingStatus.values
          .where(
            (BookingStatus element) =>
                element.value.toString() == dataNotificationModel.bookingStatus,
          )
          .toList()
          .first;
      _idBooking = dataNotificationModel.bookingId;
      add(UpdateStatusBookingEvent(bookingStatus!));
    });
  }

  FutureOr<void> _updateStatusBookingEvent(
    UpdateStatusBookingEvent event,
    Emitter<TrackingPageState> emitter,
  ) {
    if (event.bookingStatus == BookingStatus.driverFound) {
      add(GetBookingInfoByIdEvent(_idBooking ?? ''));
      log('get information driver after accept');
    }
    log('event.bookingStatus:${event.bookingStatus}');
    emitter(
      state.copyWith(bookingStatus: event.bookingStatus),
    );
  }

  FutureOr<void> _cancelBookingDriverAppEvent(
    CancelBookingDriverAppEvent event,
    Emitter<TrackingPageState> emitter,
  ) async {
    final DataState<CanceBookingDriverModel> dataState = await _trackingPageRepo
        .cancelBookingDriverApp(driverBookingId: event.driverBookingId);

    emitter(
      state.copyWith(
        errorMessage: dataState.isError() ? dataState.data?.errorMessage : '',
      ),
    );
  }

  FutureOr<void> _confirmPickUpPassengerDriverApp(
    ConfirmPickUpPassengerDriverAppEvent event,
    Emitter<TrackingPageState> emitter,
  ) async {
    final DataState<ConfirmPickUpPassengerModel> dataState =
        await _trackingPageRepo.confirmPickUpPassengerDriverApp(
      driverBookingId: event.driverBookingId,
    );

    emitter(
      state.copyWith(
        errorMessage: dataState.isError() ? dataState.data?.errorMessage : '',
      ),
    );
  }

  FutureOr<void> _finishTripDriverApp(
    FinishTripDriverAppEvent event,
    Emitter<TrackingPageState> emitter,
  ) async {
    final DataState<FinishTripDriverAppModel> dataState =
        await _trackingPageRepo.finishTripDriverApp(
      driverBookingId: event.driverBookingId,
    );

    emitter(
      state.copyWith(
        errorMessage: dataState.isError() ? dataState.data?.errorMessage : '',
      ),
    );
  }

  FutureOr<void> _almostArriveDriverAppEvent(
    AlmostArriveDriverAppEvent event,
    Emitter<TrackingPageState> emitter,
  ) async {
    DataState<AlmostArriveDriverAppModel> dataState =
        await _trackingPageRepo.almostArriveDriverApp(
      driverBookingId: event.driverBookingId,
    );
    emitter(
      state.copyWith(
        errorMessage: dataState.isError() ? dataState.data?.errorMessage : '',
      ),
    );
  }

  FutureOr<void> _arrivePickUpToDriverAppDriverAppEvent(
    ArrivePickUpToDriverAppDriverAppEvent event,
    Emitter<TrackingPageState> emitter,
  ) async {
    DataState<ArrivePickUpToDriverAppModel> dataState =
        await _trackingPageRepo.arrivePickUpToDriverApp(
      driverBookingId: event.driverBookingId,
    );
    emitter(
      state.copyWith(
        errorMessage: dataState.isError() ? dataState.data?.errorMessage : '',
      ),
    );
  }

  FutureOr<void> _reSearchBookingEvent(
    ReSearchBookingEvent event,
    Emitter<TrackingPageState> emitter,
  ) {
    emitter(
      state.copyWith(
        bookingStatus: BookingStatus.searching,
      ),
    );
  }
}
