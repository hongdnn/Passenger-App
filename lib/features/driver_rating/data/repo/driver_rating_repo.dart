import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/driver_rating/data/model/request/rate_driver_request.dart';
import 'package:passenger/features/driver_rating/data/model/response/rating_reason.dart';
import 'package:passenger/features/driver_rating/data/model/response/rating_result.dart';

abstract class DriverRatingRepo {
  Future<DataState<RatingResult?>> rateDriver(RateDriverRequest request);

  Future<DataState<RatingOptions>> getRatingOptions({
    required String bookingId,
  });
}
