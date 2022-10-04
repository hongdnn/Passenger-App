import 'package:dio/dio.dart';
import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/order_history/data/model/booking_history_trip_model.dart';
import 'package:passenger/features/order_history/data/repo/booking_history_trip_repo.dart';

class BookingHistoryTripRepoImpl implements BookingHistoryTripRepo {
  BookingHistoryTripRepoImpl(this.rhBaseApi);

  final RhBaseApi rhBaseApi;

  @override
  Future<DataState<BookingHistoryTripModel>> getBookingHistory(
    String userId,
    int status,
    int page,
    int pageSize,
  ) async {
    try {
      final BookingHistoryTripModel result = await rhBaseApi.getBookingHistory(
        userId: userId,
        status: status,
        page: page,
        pageSize: pageSize,
      );
      return DataSuccess<BookingHistoryTripModel>(result);
    } on DioError catch (e) {
      final BookingHistoryTripModel value = BookingHistoryTripModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<BookingHistoryTripModel>(value);
    } on Exception catch (e) {
      return DataFailed<BookingHistoryTripModel>(e);
    }
  }
}
