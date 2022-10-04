import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/landing_page/data/common_model/common_model.dart';
import 'package:passenger/features/landing_page/data/model/check_booking_availability_model.dart';

abstract class CheckoutRepository {
  Future<DataState<CheckBookingAvailabilityModel>> checkBookingAvailability({
    required String userId,
  });

  Future<DataState<Trip>> getDraftingTripByDeviceId({
    required String deviceId,
  });
}
