import 'package:dio/dio.dart';
import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/features/booking_page/data/model/drafting_trip_response.dart';
import 'package:passenger/features/checkout/data/repo/checkout_repo.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/landing_page/data/model/check_booking_availability_model.dart';

import 'package:passenger/core/util/data_state.dart';

class CheckoutRepositoryImpl extends CheckoutRepository {
  CheckoutRepositoryImpl(this._baseApi);

  final RhBaseApi _baseApi;

  @override
  Future<DataState<CheckBookingAvailabilityModel>> checkBookingAvailability({
    required String userId,
  }) async {
    try {
      CheckBookingAvailabilityModel result =
          await _baseApi.checkBookingAvailability(userId: userId);

      return DataSuccess<CheckBookingAvailabilityModel>(result);
    } on DioError catch (e) {
      final CheckBookingAvailabilityModel value =
          CheckBookingAvailabilityModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<CheckBookingAvailabilityModel>(value);
    }
  }

  @override
  Future<DataState<Trip>> getDraftingTripByDeviceId({
    required String deviceId,
  }) async {
    try {
      DraftingTripResponse result =
          await _baseApi.getDraftingTripByDeviceId(deviceId: deviceId);

      return DataSuccess<Trip>(result.data!);
    } on DioError catch (e) {
      return DataFailed<Trip>(e);
    }
  }
}
