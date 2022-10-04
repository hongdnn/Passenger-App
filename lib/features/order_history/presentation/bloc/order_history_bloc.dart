import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/order_history/data/model/booking_history_trip_model.dart';
import 'package:passenger/features/order_history/data/repo/booking_history_trip_repo.dart';
import 'package:passenger/features/user/data/model/user.dart';
import 'package:passenger/features/user/data/repo/user_repo.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/util.dart';

part 'order_history_event.dart';

part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc(this.bookingHistoryTripRepo, this.userRepo)
      : super(OrderHistoryState()) {
    on<GetBookingHistoryEvent>(
      getListBooking,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
    on<GetBookingHistoryInitEvent>(
      getListInitBooking,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
    on<GetNextPageListBookingEvent>(
      getNextPageOnLoading,
    );
  }

  final BookingHistoryTripRepo bookingHistoryTripRepo;
  final UserRepo userRepo;

  bool _isLastPage = false;

  int _currentPage = 1;

  User getCurrentUser() {
    return userRepo.getCurrentUser();
  }

  Future<void> getListBooking(
    GetBookingHistoryEvent event,
    Emitter<OrderHistoryState> emitter,
  ) async {
    emitter(
      state.copyWith(
        historyBookingState: state.dataBooking?.isNotEmpty == true
            ? LoadState.success
            : LoadState.loading,
        isLazyLoading: event.isLazyLoading,
      ),
    );
    final DataState<BookingHistoryTripModel> bookingHistoryTripModel =
        await bookingHistoryTripRepo.getBookingHistory(
      getCurrentUser().id,
      event.status,
      _currentPage,
      historyTripPageLimit,
    );

    if (bookingHistoryTripModel.data?.data?.bookings?.isEmpty == true) {
      _isLastPage = true;
      emitter(
        state.copyWith(
          isLastPage: _isLastPage,
          isLazyLoading: false,
        ),
      );
      return;
    }

    List<BookingData> currentHistoryData = state.dataBooking ?? <BookingData>[];
    if (_currentPage == 1) {
      currentHistoryData =
          bookingHistoryTripModel.data?.data?.bookings ?? <BookingData>[];
    } else {
      currentHistoryData.addAll(
        bookingHistoryTripModel.data?.data?.bookings ?? <BookingData>[],
      );
    }

    _isLastPage = false;
    emitter(
      state.copyWith(
        historyBookingState: bookingHistoryTripModel.isSuccess()
            ? LoadState.success
            : LoadState.failure,
        dataBooking: bookingHistoryTripModel.isSuccess()
            ? currentHistoryData
            : (state.dataBooking ?? currentHistoryData),
        isLazyLoading: false,
        isLastPage: _isLastPage,
      ),
    );
  }

  Future<void> getListInitBooking(
    GetBookingHistoryInitEvent event,
    Emitter<OrderHistoryState> emitter,
  ) async {
    emitter(
      state.copyWith(
        historyBookingState: state.dataBooking?.isNotEmpty == true
            ? LoadState.success
            : LoadState.loading,
      ),
    );

    final DataState<BookingHistoryTripModel> bookingHistoryTripModel =
        await bookingHistoryTripRepo.getBookingHistory(
      getCurrentUser().id,
      event.status,
      historyTripFirstPage,
      historyTripPageLimit,
    );
    final List<BookingData> dataBooking =
        bookingHistoryTripModel.data?.data?.bookings ?? <BookingData>[];
    emitter(
      state.copyWith(
        historyBookingState: bookingHistoryTripModel.isSuccess()
            ? LoadState.success
            : LoadState.failure,
        isLazyLoading: false,
        isLastPage: _isLastPage,
        dataBooking: dataBooking,
      ),
    );
  }

  Future<void> getNextPageOnLoading(
    GetNextPageListBookingEvent event,
    Emitter<OrderHistoryState> emitter,
  ) async {
    _currentPage = _currentPage + 1;
    emitter(
      state.copyWith(currentPage: _currentPage),
    );
  }
}
