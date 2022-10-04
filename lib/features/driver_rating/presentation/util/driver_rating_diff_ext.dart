import 'package:flutter/widgets.dart';
import 'package:passenger/features/driver_rating/presentation/bloc/driver_rating_bloc.dart';
import 'package:passenger/features/driver_rating/presentation/driver_rating_page.dart';

extension DriverRatingDiffExtension on State<DriverRatingPage> {
  bool shouldRebuildReasonPicker(
    DriverRatingState previous,
    DriverRatingState current,
  ) {
    return previous.selectedReasons != current.selectedReasons ||
        previous.rating != current.rating;
  }

  bool shouldRebuildTipPicker(
    DriverRatingState previous,
    DriverRatingState current,
  ) {
    return previous.selectedTip != current.selectedTip;
  }

  bool shouldRebuildDriverInfo(
    DriverRatingState previous,
    DriverRatingState current,
  ) {
    return previous.ratingOptions != current.ratingOptions;
  }

  bool shouldRebuildMainContent(
    DriverRatingState previous,
    DriverRatingState current,
  ) {
    return previous.initialLoadState != current.initialLoadState;
  }
}
