import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:passenger/core/network/gg_client.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/booking_page/presentation/bloc/booking_page_bloc.dart';
import 'package:passenger/features/location/data/model/direction_model.dart';
import 'package:passenger/features/location/data/repo/direction_result_model.dart';
import 'package:passenger/util/colors.dart';
import 'package:passenger/util/size.dart';
import 'package:passenger/util/util.dart';

part 'polyline_repo_impl.dart';

abstract class PolylineRepo {
  void resetPolylines();

  List<DirectionResultModel>? getLatestPolylineList();

  Future<DataState<List<TotalDirectionResultModel>>>
      getDirectionFromOriginToDestination({
    required List<DirectionParam> directionParams,
  });

  Future<DataState<List<TotalDirectionResultModel>>>
      getAlternativesDirectionFromOriginToDestination({
    required List<DirectionParam> directionParams,
  });

  double? getDistance();

  double? getDuration();

  void setPolylines(
    List<DirectionResultModel>? newPolylnes,
    double? duration,
    double? distance,
  );
}
