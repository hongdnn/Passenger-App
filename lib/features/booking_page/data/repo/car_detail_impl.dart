import 'package:dio/dio.dart';
import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/booking_page/data/model/car_detail.dart';
import 'package:passenger/features/booking_page/data/repo/car_repo.dart';

class CarRepoImpl implements CarRepo {
  CarRepoImpl(this.rhBaseApi);

  final RhBaseApi rhBaseApi;

  @override
  Future<DataState<CarDescription>> getCarDetail(
    CarBodyRequest carBodyRequest,
  ) async {
    try {
      final CarDescription result =
          await rhBaseApi.getCarDetail(carBodyRequest);
      return DataSuccess<CarDescription>(result);
    } on DioError catch (e) {
      final CarDescription value = CarDescription.fromJson(
        e.response?.data as Map<String, dynamic>,
      );
      return DataSuccess<CarDescription>(value);
    } on Exception catch (e) {
      return DataFailed<CarDescription>(e);
    }
  }
}
