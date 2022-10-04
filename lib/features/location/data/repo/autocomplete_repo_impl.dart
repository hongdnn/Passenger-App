import 'package:passenger/core/network/gg_client.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/location/data/model/autocomplete_model.dart';
import 'package:passenger/features/location/data/model/direction_model.dart';
import 'package:passenger/features/location/data/repo/autocomplete_repo.dart';

class AutoCompleteRepoImpl implements AutocompleteRepo {
  AutoCompleteRepoImpl(this.ggClientApi);

  final GgClientApi ggClientApi;

  @override
  Future<DataState<GgAutoComplete>> getListGGAutocomplete(
    String keyword,
  ) async {
    try {
      final GgAutoComplete result =
          await ggClientApi.getListAutoComplete(keyword: keyword);

      return DataSuccess<GgAutoComplete>(result);
    } on Exception catch (e) {
      return DataFailed<GgAutoComplete>(e);
    }
  }

  @override
  Future<DataState<DirectionModel>> getDirectionFromOriginToDestination({
    required String origin,
    required String destination,
    required String travelmode,
    bool? avoidHighways,
    bool? avoidTolls,
    bool? avoidFerries,
    bool? optimizeWaypoints,
  }) async {
    try {
      final DirectionModel result =
          await ggClientApi.getDirectionFromOriginToDestination(
        origin: origin,
        destination: destination,
        travelmode: travelmode,
        avoidFerries: avoidFerries,
        avoidHighways: avoidHighways,
        avoidTolls: avoidTolls,
        optimizeWaypoints: optimizeWaypoints,
      );
      return DataSuccess<DirectionModel>(result);
    } on Exception catch (e) {
      return DataFailed<DirectionModel>(e);
    }
  }
}
