import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/map_page/data/model/list_car_by_location_model.dart';

abstract class MapPageRepo {
  Future<DataState<ListCarByLocationModel>> getListCarLocation({
    required double desLat,
    required double desLng,
    required double depLng,
    required double depLat,
    required double distance,
  });
}
