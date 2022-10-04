import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/landing_page/data/model/check_booking_availability_model.dart';
import 'package:passenger/features/tracking_page/data/model/driver_accept_booking_model.dart';

abstract class BookingAvailabilityRepo {
  Future<DataState<CheckBookingAvailabilityModel>> checkBookingAvailability(
    String userId,
  );
  Future<DataState<DriverAcceptBookingModel>> getBookingAvailabilityInfo(
    String id,
  );
}
