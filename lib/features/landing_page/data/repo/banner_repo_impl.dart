import 'package:dio/dio.dart';
import 'package:passenger/core/network/rh_base_api.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/landing_page/data/model/banner_model.dart';
import 'package:passenger/features/landing_page/data/repo/banner_repo.dart';

class BannerRepoImpl implements BannerRepo {
  BannerRepoImpl(this.rhBaseApi);

  final RhBaseApi rhBaseApi;

  @override
  Future<DataState<BannerResponse>> getBanners() async {
    try {
      final BannerResponse result = await rhBaseApi.getBanners();
      return DataSuccess<BannerResponse>(result);
    } on DioError catch (e) {
      final BannerResponse value = BannerResponse.fromJson(
        e.response?.data as Map<String, dynamic>,
      );

      return DataSuccess<BannerResponse>(value);
    } on Exception catch (e) {
      return DataFailed<BannerResponse>(e);
    }
  }
}
