import 'package:dio/dio.dart';
import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/favorite_location/data/model/favorite_location.dart';
import 'package:passenger/features/favorite_location/data/repo/favorite_location_repo.dart';

class FavoriteLocationRepoImpl implements FavoriteLocationRepo {
  FavoriteLocationRepoImpl(this.rhBaseApi);

  final RhBaseApi rhBaseApi;

  @override
  Future<DataState<List<FavoriteLocation>>> getFavoriteLocationByUserId(
    String userId,
  ) async {
    try {
      final FavoriteLocationListReponse result =
          await rhBaseApi.getFavoriteLocationsByUserId(userId);
      return DataSuccess<List<FavoriteLocation>>(
        result.data ?? <FavoriteLocation>[],
      );
    } on Exception catch (e) {
      return DataFailed<List<FavoriteLocation>>(e);
    }
  }

  @override
  Future<DataState<FavoriteLocation>> addFavoriteLocation(
    FavoriteLocation favoriteLocation,
  ) async {
    try {
      final FavoriteLocationResponse result =
          await rhBaseApi.addFavoriteLocation(favoriteLocation);
      return DataSuccess<FavoriteLocation>(result.data!);
    } on DioError catch (e) {
      final FavoriteLocation value = FavoriteLocation.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<FavoriteLocation>(value);
    } on Exception catch (e) {
      return DataFailed<FavoriteLocation>(e);
    }
  }

  @override
  Future<bool> deleteFavoriteLocationById(
    String id,
  ) async {
    try {
      await rhBaseApi.deleteFavoriteLocationById(id);
      return true;
    } on DioError catch (_) {
      return false;
    } on Exception catch (_) {
      return false;
    }
  }

  @override
  Future<DataState<FavoriteLocation>> getFavoriteLocationById(String id) async {
    try {
      final FavoriteLocationResponse result =
          await rhBaseApi.getFavoriteLocationById(id);
      return DataSuccess<FavoriteLocation>(result.data!);
    } on DioError catch (e) {
      final FavoriteLocation value = FavoriteLocation.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<FavoriteLocation>(value);
    } on Exception catch (e) {
      return DataFailed<FavoriteLocation>(e);
    }
  }

  @override
  Future<DataState<FavoriteLocation>> updateFavoriteLocation(
    FavoriteLocation favoriteLocation,
  ) async {
    try {
      final FavoriteLocationResponse result =
          await rhBaseApi.updateFavoriteLocation(favoriteLocation);
      return DataSuccess<FavoriteLocation>(result.data!);
    } on DioError catch (e) {
      final FavoriteLocation value = FavoriteLocation.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<FavoriteLocation>(value);
    } on Exception catch (e) {
      return DataFailed<FavoriteLocation>(e);
    }
  }
}
