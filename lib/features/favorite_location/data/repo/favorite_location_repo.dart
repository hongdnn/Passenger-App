import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/favorite_location/data/model/favorite_location.dart';

abstract class FavoriteLocationRepo {
  Future<DataState<List<FavoriteLocation>>> getFavoriteLocationByUserId(
    String userId,
  );

  Future<DataState<FavoriteLocation>> addFavoriteLocation(
    FavoriteLocation favoriteLocation,
  );

  Future<DataState<FavoriteLocation>> updateFavoriteLocation(
    FavoriteLocation favoriteLocation,
  );

  Future<DataState<FavoriteLocation>> getFavoriteLocationById(
    String id,
  );

  Future<bool> deleteFavoriteLocationById(
    String id,
  );
}
