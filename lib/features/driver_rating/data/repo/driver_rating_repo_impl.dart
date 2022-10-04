import 'package:dio/dio.dart';
import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/driver_rating/data/model/request/rate_driver_request.dart';
import 'package:passenger/features/driver_rating/data/model/response/rating_reason.dart';
import 'package:passenger/features/driver_rating/data/model/response/rating_result.dart';
import 'package:passenger/features/driver_rating/data/repo/driver_rating_repo.dart';

class DriverRatingRepoImpl extends DriverRatingRepo {
  DriverRatingRepoImpl(this.rhBaseApi);

  final RhBaseApi rhBaseApi;

  @override
  Future<DataState<RatingOptions>> getRatingOptions({
    required String bookingId,
  }) async {
    try {
      final RatingOptionsResponse response =
          await rhBaseApi.getRatingOptions(bookingId: bookingId);

      return DataSuccess<RatingOptions>(response.data!);
    } on DioError catch (e) {
      final RatingOptions value = RatingOptions.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<RatingOptions>(value);
    } on Exception catch (e) {
      return DataFailed<RatingOptions>(e);
    }
  }

  @override
  Future<DataState<RatingResult?>> rateDriver(RateDriverRequest request) async {
    try {
      await rhBaseApi.rateDriver(request: request);
      return const DataSuccess<RatingResult?>(null);
    } on DioError catch (e) {
      final RatingResult value = RatingResult.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<RatingResult>(value);
    } on Exception catch (e) {
      return DataFailed<RatingResult?>(e);
    }
  }
}
