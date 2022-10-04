import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passenger/core/app_config/constant.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/driver_rating/data/model/request/rate_driver_request.dart';
import 'package:passenger/features/driver_rating/data/model/response/rating_reason.dart';
import 'package:passenger/features/driver_rating/data/model/response/rating_result.dart';
import 'package:passenger/features/driver_rating/data/repo/driver_rating_repo.dart';
import 'package:passenger/util/enum.dart';
import 'package:passenger/util/util.dart';

part 'driver_rating_event.dart';
part 'driver_rating_state.dart';

class DriverRatingBloc extends Bloc<DriverRatingEvent, DriverRatingState> {
  DriverRatingBloc(this._driverRatingRepo) : super(DriverRatingState()) {
    on<InitializeRating>(_onInitialize);
    on<SelectStarEvent>(_onStarSelected);
    on<SelectReasonEvent>(_onReasonSelected);
    on<SelectTipEvent>(_onTipSelected);
    on<ConfirmRatingEvent>(_onConfirmRateDriver);
    on<CommentEvent>(
      _onCommentChanged,
      transformer: debounce(const Duration(milliseconds: defaultDebounceTime)),
    );
  }

  final DriverRatingRepo _driverRatingRepo;

  Future<void> _onInitialize(
    InitializeRating event,
    Emitter<DriverRatingState> emit,
  ) async {
    emit(state.copyWith(initialLoadState: LoadState.loading));

    final DataState<RatingOptions> ratingOptions =
        await _driverRatingRepo.getRatingOptions(bookingId: event.bookingId);

    emit(
      state.copyWith(
        initialLoadState:
            ratingOptions.isSuccess() ? LoadState.success : LoadState.failure,
        ratingOptions: ratingOptions.data,
      ),
    );
  }

  FutureOr<void> _onStarSelected(
    SelectStarEvent event,
    Emitter<DriverRatingState> emit,
  ) {
    if (event.rating == state.rating) return Future<void>.value();
    emit(state.copyWith(selectedReasons: <String>[], rating: event.rating));
  }

  FutureOr<void> _onReasonSelected(
    SelectReasonEvent event,
    Emitter<DriverRatingState> emit,
  ) {
    final List<String> selectedReasons =
        List<String>.from(state.selectedReasons ?? <String>[]);
    if (state.selectedReasons?.contains(event.reason) == true) {
      selectedReasons.removeWhere(
        (String element) => element == event.reason,
      );
    } else {
      selectedReasons.add(event.reason);
    }

    emit(state.copyWith(selectedReasons: selectedReasons));
  }

  FutureOr<void> _onTipSelected(
    SelectTipEvent event,
    Emitter<DriverRatingState> emit,
  ) {
    emit(
      state.copyWith(
        selectedTip: state.selectedTip == event.tip ? -1 : event.tip,
      ),
    );
  }

  FutureOr<void> _onCommentChanged(
    CommentEvent event,
    Emitter<DriverRatingState> emit,
  ) {
    if (event.text == state.comment) return Future<void>.value();
    emit(state.copyWith(comment: event.text));
  }

  FutureOr<void> _onConfirmRateDriver(
    ConfirmRatingEvent event,
    Emitter<DriverRatingState> emit,
  ) async {
    if (!_validateInput()) {
      return;
    }
    emit(state.copyWith(confirmLoadState: LoadState.loading));
    final RateDriverRequest request = event.ratingRequest;
    final DataState<RatingResult?> result =
        await _driverRatingRepo.rateDriver(request);
    emit(
      state.copyWith(
        confirmLoadState:
            result.isSuccess() ? LoadState.success : LoadState.failure,
      ),
    );
  }

  bool _validateInput() {
    // TODO: Add more conditions here
    return true;
  }
}
