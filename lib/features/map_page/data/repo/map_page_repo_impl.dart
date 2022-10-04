import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/features/map_page/data/model/list_car_location_request.dart';
import 'package:passenger/features/map_page/data/model/list_car_by_location_model.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/map_page/data/repo/map_page_repo.dart';

class MapPageRepoImpl implements MapPageRepo {
  MapPageRepoImpl(this._rhBaseApi);

  final RhBaseApi _rhBaseApi;

  @override
  Future<DataState<ListCarByLocationModel>> getListCarLocation({
    required double desLat,
    required double desLng,
    required double depLng,
    required double depLat,
    required double distance,
  }) async {
    try {
      final ListCarByLocationModel result = await _rhBaseApi.getListCarLocation(
        listCarLocationRequest: ListCarLocationRequest(
          distance: distance,
          desLat: desLat,
          desLng: desLng,
          depLat: depLat,
          depLng: depLng,
        ),
      );

      return DataSuccess<ListCarByLocationModel>(result);
    } on Exception catch (e) {
      return DataFailed<ListCarByLocationModel>(e);
    }
  }
}
