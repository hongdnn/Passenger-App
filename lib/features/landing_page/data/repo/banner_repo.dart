import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/landing_page/data/model/banner_model.dart';

abstract class BannerRepo {
  Future<DataState<BannerResponse>> getBanners();
}
