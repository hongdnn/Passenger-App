import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/landing_page/data/model/booking_history_model.dart';
import 'package:passenger/features/landing_page/data/model/booking_history_sort_by_time_model.dart';
import 'package:passenger/features/landing_page/data/model/like_request_model.dart';
import 'package:passenger/features/landing_page/data/repo/booking_history_repo.dart';

class BookingHistoryRepoImpl implements BookingHistoryRepo {
  BookingHistoryRepoImpl(this.rhBaseApi);
  RhBaseApi rhBaseApi;

  @override
  Future<DataState<BookingHistoryModel>> getListBookingHistory(
    String userId,
    int limit,
  ) async {
    try {
      final BookingHistoryModel result =
          await rhBaseApi.getListBookingHistory(userId: userId, limit: limit);
      return DataSuccess<BookingHistoryModel>(result);
    } on DioError catch (e) {
      final BookingHistoryModel value = BookingHistoryModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<BookingHistoryModel>(value);
    } on Exception catch (e) {
      return DataFailed<BookingHistoryModel>(e);
    }
  }

  @override
  Future<DataState<BookingHistorySortByTimeModel>>
      getListBookingHistorySortByTime(String userId, int limit) async {
    try {
      final BookingHistorySortByTimeModel result = await rhBaseApi
          .getBookingHistorySortByTime(userId: userId, limit: limit);
      return DataSuccess<BookingHistorySortByTimeModel>(result);
    } on DioError catch (e) {
      final BookingHistorySortByTimeModel value =
          BookingHistorySortByTimeModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<BookingHistorySortByTimeModel>(value);
    } on Exception catch (e) {
      return DataFailed<BookingHistorySortByTimeModel>(e);
    }
  }

  @override
  Future<void> setLikeForBookingHistory({
    required LikeRequestModel body,
    required String id,
  }) async {
    try {
      await rhBaseApi.setLikeForBookingHistory(bodyRequest: body, id: id);
    } on Exception catch (e) {
      log(e.toString());
    }
  }
}
