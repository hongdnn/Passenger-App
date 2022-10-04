import 'package:dio/dio.dart';
import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/features/landing_page/data/model/check_booking_availability_model.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/landing_page/data/repo/booking_availability_repo.dart';
import 'package:passenger/features/tracking_page/data/model/driver_accept_booking_model.dart';

class BookingAvailabilityRepoImpl implements BookingAvailabilityRepo {
  BookingAvailabilityRepoImpl(this.rhBaseApi);

  final RhBaseApi rhBaseApi;

  @override
  Future<DataState<CheckBookingAvailabilityModel>> checkBookingAvailability(
    String userId,
  ) async {
    try {
      final CheckBookingAvailabilityModel result =
          await rhBaseApi.checkBookingAvailability(userId: userId);
      return DataSuccess<CheckBookingAvailabilityModel>(result);
    } on DioError catch (e) {
      final CheckBookingAvailabilityModel value =
          CheckBookingAvailabilityModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<CheckBookingAvailabilityModel>(value);
    } on Exception catch (e) {
      return DataFailed<CheckBookingAvailabilityModel>(e);
    }
  }

  @override
  Future<DataState<DriverAcceptBookingModel>> getBookingAvailabilityInfo(
    String id,
  ) async {
    try {
      final DriverAcceptBookingModel result =
          await rhBaseApi.getBookingById(id: id);
      return DataSuccess<DriverAcceptBookingModel>(result);
    } on DioError catch (e) {
      final DriverAcceptBookingModel value = DriverAcceptBookingModel.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataFailed<DriverAcceptBookingModel>(e, data: value);
    } on Exception catch (e) {
      return DataFailed<DriverAcceptBookingModel>(e);
    }
  }
}
