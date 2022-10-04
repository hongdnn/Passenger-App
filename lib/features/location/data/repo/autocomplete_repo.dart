import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/location/data/model/autocomplete_model.dart';
import 'package:passenger/features/location/data/model/direction_model.dart';

abstract class AutocompleteRepo {
  Future<DataState<GgAutoComplete>> getListGGAutocomplete(String keyword);

  Future<DataState<DirectionModel>> getDirectionFromOriginToDestination({
    required String origin,
    required String destination,
    required String travelmode,
    bool? avoidHighways,
    bool? avoidTolls,
    bool? avoidFerries,
    bool? optimizeWaypoints,
  });
}
