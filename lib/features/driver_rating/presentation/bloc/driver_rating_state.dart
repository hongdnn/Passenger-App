part of 'driver_rating_bloc.dart';

class DriverRatingState {
  DriverRatingState({
    this.rating = 0,
    this.selectedReasons,
    this.comment,
    this.selectedTip = defaultSelectedTip,
    this.confirmLoadState = LoadState.none,
    this.initialLoadState = LoadState.none,
    this.ratingOptions,
  });

  final int rating;
  final List<String>? selectedReasons;
  final String? comment;
  final num? selectedTip;
  final LoadState confirmLoadState;
  final LoadState initialLoadState;
  final RatingOptions? ratingOptions;

  List<String> get displayedReason {
    for (Review review in ratingOptions?.reviews ?? <Review>[]) {
      if ((review.ratingStar ?? <num>[]).contains(rating)) {
        return review.reasons ?? <String>[];
      }
    }
    return <String>[];
  }

  DriverRatingState copyWith({
    int? rating,
    List<String>? selectedReasons,
    String? comment,
    List<num>? tips,
    num? selectedTip,
    String? driverInfo,
    LoadState? confirmLoadState,
    LoadState? initialLoadState,
    RatingOptions? ratingOptions,
  }) {
    return DriverRatingState(
      rating: rating ?? this.rating,
      selectedReasons: selectedReasons ?? this.selectedReasons,
      comment: comment ?? this.comment,
      selectedTip: selectedTip ?? this.selectedTip,
      confirmLoadState: confirmLoadState ?? this.confirmLoadState,
      initialLoadState: initialLoadState ?? this.initialLoadState,
      ratingOptions: ratingOptions ?? this.ratingOptions,
    );
  }
}
