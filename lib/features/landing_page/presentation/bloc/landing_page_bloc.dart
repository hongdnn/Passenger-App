import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/app_config/notification/data_notification_model.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/landing_page/data/model/banner_model.dart';
import 'package:passenger/features/landing_page/data/model/booking_history_model.dart';
import 'package:passenger/features/landing_page/data/model/booking_history_sort_by_time_model.dart';
import 'package:passenger/features/landing_page/data/model/check_booking_availability_model.dart';
import 'package:passenger/features/landing_page/data/model/like_request_model.dart';
import 'package:passenger/features/landing_page/data/repo/banner_repo.dart';
import 'package:passenger/features/landing_page/data/repo/booking_availability_repo.dart';
import 'package:passenger/features/landing_page/data/repo/booking_history_repo.dart';
import 'package:passenger/features/location/data/repo/current_location_repo.dart';
import 'package:passenger/features/tracking_page/data/model/driver_accept_booking_model.dart';
import 'package:passenger/features/user/data/model/user.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/util.dart';

part 'landing_page_event.dart';

part 'landing_page_state.dart';

class LandingPageBloc extends Bloc<LandingPageEvent, LandingPageState> {
  LandingPageBloc(
    this.bannerRepo,
    this.bookingHistoryRepo,
    this.currentLocationRepo,
    this.userRepo,
    this.bookingAvailabilityRepo,
  ) : super(LandingPageState()) {
    _listenNotification();
    on<GetBannerEvent>(
      getBanners,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
    on<GetBookingHistoryEvent>(
      getListBookingHistory,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
    on<SetLikeForBookingEvent>(
      setLikeForBooking,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
    on<GetBookingHistorySortByTimeEvent>(
      getListBookingHistorySortByTime,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
    on<RefreshAllDataEvent>(_refreshAllData);
    on<InitializeLandingEvent>(_initialize);
    on<CheckBookingAvailabilityEvent>(checkBookingAvailability);
    on<GetBookingByIdEvent>(getDriverAcceptBookingInfo);
    on<ClearDataLandingEvent>(clearData);
    on<UpdateStatusBookingEvent>(_updateStatusBookingEvent);
  }

  final BannerRepo bannerRepo;
  final BookingHistoryRepo bookingHistoryRepo;
  final CurrentLocationRepo currentLocationRepo;
  final UserRepo userRepo;
  final BookingAvailabilityRepo bookingAvailabilityRepo;
  late StreamSubscription<RemoteMessage> _streamNotification;

  User getCurrentUser() {
    return userRepo.getCurrentUser();
  }

  FutureOr<void> _listenNotification() async {
    log('_listenNotification');

    BookingStatus? bookingStatus;
    _streamNotification =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      DataNotificationModel dataNotificationModel =
          DataNotificationModel.fromJson(message.data);
      bookingStatus = BookingStatus.values
          .where(
            (BookingStatus element) =>
                element.value.toString() == dataNotificationModel.bookingStatus,
          )
          .toList()
          .first;
      log('bookingStatus:$bookingStatus');
      add(UpdateStatusBookingEvent(bookingStatus!));
    });
  }

  FutureOr<void> _updateStatusBookingEvent(
    UpdateStatusBookingEvent event,
    Emitter<LandingPageState> emitter,
  ) {
    emitter(
      state.copyWith(bookingStatus: event.bookingStatus),
    );
  }

  Future<void> getBanners(
    GetBannerEvent event,
    Emitter<LandingPageState> emit,
  ) async {
    if (state.bannerResponse?.data?.isNotEmpty != true) {
      emit(
        state.copyWith(
          bannerLoadState: LoadState.loading,
        ),
      );
    }

    final DataState<BannerResponse> bannerResponseModel =
        await bannerRepo.getBanners();
    log(bannerRepo.toString());
    emit(
      state.copyWith(
        bannerLoadState: bannerResponseModel.isSuccess()
            ? LoadState.success
            : LoadState.failure,
        bannerResponse: bannerResponseModel.isSuccess()
            ? bannerResponseModel.data
            : (state.bannerResponse ?? bannerResponseModel.data),
      ),
    );
  }

  Future<void> getListBookingHistory(
    GetBookingHistoryEvent event,
    Emitter<LandingPageState> emit,
  ) async {
    emit(
      state.copyWith(
        getBookingHistoryLoadState: LoadState.loading,
      ),
    );

    final DataState<BookingHistoryModel> bookingHistoryModel =
        await bookingHistoryRepo.getListBookingHistory(
      getCurrentUser().id,
      event.limit,
    );

    emit(
      state.copyWith(
        getBookingHistoryLoadState: bookingHistoryModel.isSuccess()
            ? LoadState.success
            : LoadState.failure,
        bookingHistoryModel: bookingHistoryModel.isSuccess()
            ? bookingHistoryModel.data
            : (state.bookingHistoryModel ?? bookingHistoryModel.data),
      ),
    );
  }

  Future<void> setLikeForBooking(
    SetLikeForBookingEvent event,
    Emitter<LandingPageState> emit,
  ) async {
    try {
      await bookingHistoryRepo.setLikeForBookingHistory(
        body: event.requestBody,
        id: event.id,
      );

      final DataState<BookingHistoryModel> bookingHistoryModel =
          await bookingHistoryRepo.getListBookingHistory(
        getCurrentUser().id,
        limitBookingHistoryCount,
      );

      emit(
        state.copyWith(
          getBookingHistoryLoadState: LoadState.success,
          bookingHistoryModel: bookingHistoryModel.isSuccess()
              ? bookingHistoryModel.data
              : state.bookingHistoryModel,
        ),
      );
    } on Exception catch (_) {}
  }

  FutureOr<void> _initialize(
    InitializeLandingEvent event,
    Emitter<LandingPageState> emit,
  ) async {
    add(RefreshAllDataEvent());
  }

  FutureOr<void> _refreshAllData(
    RefreshAllDataEvent event,
    Emitter<LandingPageState> emit,
  ) {
    add(GetBannerEvent());
    add(
      GetBookingHistoryEvent(limitBookingHistoryCount),
    );
    add(
      GetBookingHistorySortByTimeEvent(limitBookingHistorySortByTimeCount),
    );
    add(
      CheckBookingAvailabilityEvent(),
    );
  }

  Future<void> getListBookingHistorySortByTime(
    GetBookingHistorySortByTimeEvent event,
    Emitter<LandingPageState> emit,
  ) async {
    emit(
      state.copyWith(
        getBookingHistorySortByTimeLoadState: LoadState.loading,
      ),
    );

    final DataState<BookingHistorySortByTimeModel>
        bookingHistorySortByTimeModel =
        await bookingHistoryRepo.getListBookingHistorySortByTime(
      getCurrentUser().id,
      event.limit,
    );
    log(bookingHistorySortByTimeModel.toString());

    emit(
      state.copyWith(
        getBookingHistorySortByTimeLoadState:
            bookingHistorySortByTimeModel.isSuccess()
                ? LoadState.success
                : LoadState.failure,
        bookingHistorySortByTimeModel: bookingHistorySortByTimeModel.isSuccess()
            ? bookingHistorySortByTimeModel.data
            : (state.bookingHistorySortByTimeModel ??
                bookingHistorySortByTimeModel.data),
      ),
    );
  }

  Future<void> checkBookingAvailability(
    CheckBookingAvailabilityEvent event,
    Emitter<LandingPageState> emit,
  ) async {
    emit(
      state.copyWith(
        checkBookingAvailabilityStatus: LoadState.loading,
        checkBookingAvailabilityModel: null,
        driverAcceptBookingStatus: LoadState.none,
      ),
    );

    final DataState<CheckBookingAvailabilityModel> model =
        await bookingAvailabilityRepo.checkBookingAvailability(
      getCurrentUser().id,
    );

    emit(
      state.copyWith(
        checkBookingAvailabilityStatus:
            model.isSuccess() ? LoadState.success : LoadState.failure,
        checkBookingAvailabilityModel: model.isSuccess()
            ? model.data
            : (state.checkBookingAvailabilityModel ?? model.data),
      ),
    );
  }

  Future<void> getDriverAcceptBookingInfo(
    GetBookingByIdEvent event,
    Emitter<LandingPageState> emit,
  ) async {
    emit(
      state.copyWith(
        driverAcceptBookingStatus: LoadState.loading,
        driverAcceptBookingModel: null,
      ),
    );

    final DataState<DriverAcceptBookingModel> model =
        await bookingAvailabilityRepo.getBookingAvailabilityInfo(
      event.id,
    );
    log(model.toString());

    emit(
      state.copyWith(
        driverAcceptBookingStatus:
            model.isSuccess() ? LoadState.success : LoadState.failure,
        driverAcceptBookingModel: model.isSuccess()
            ? model.data
            : (state.driverAcceptBookingModel ?? model.data),
      ),
    );
  }

  Future<void> clearData(
    ClearDataLandingEvent event,
    Emitter<LandingPageState> emit,
  ) async {
    _streamNotification.cancel();
    emit(
      state.copyWith(
        state: LoadState.none,
        bannerLoadState: LoadState.none,
        getBookingHistoryLoadState: LoadState.none,
        getBookingHistorySortByTimeLoadState: LoadState.none,
        deviceId: null,
        bannerResponse: null,
        bookingHistoryModel: null,
        bookingHistorySortByTimeModel: null,
        checkBookingAvailabilityModel: null,
        driverAcceptBookingModel: null,
        checkBookingAvailabilityStatus: LoadState.none,
        driverAcceptBookingStatus: LoadState.none,
      ),
    );
  }
}
