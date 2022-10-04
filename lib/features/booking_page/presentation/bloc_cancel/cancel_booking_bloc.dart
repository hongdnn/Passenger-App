import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:passenger/core/util/data_state.dart';
import 'package:passenger/features/booking_page/data/model/cancel_booking_model.dart';
import 'package:passenger/features/booking_page/data/repo/booking_repo.dart';
import 'package:passenger/util/enum.dart';

part 'cancel_booking_event.dart';
part 'cancel_booking_state.dart';

class CancelBookingBloc extends Bloc<CancelBookingEvent, CancelBookingState> {
  CancelBookingBloc(this._bookingRepository) : super(CancelBookingState()) {
    on<CancelBookingEvent>(
        (CancelBookingEvent event, Emitter<CancelBookingState> emit) {
      // TODO: implement event handler
    });
    on<SelectReasonEvent>(_onSelectReasonEvent);
    on<ConfirmCancelBookingEvent>(_handleCancelBooking);
  }
  final BookingRepository _bookingRepository;

  void _onSelectReasonEvent(
    SelectReasonEvent event,
    Emitter<CancelBookingState> emit,
  ) {
    emit(CancelBookingState(idReason: event.idReason));
  }

  void _handleCancelBooking(
    ConfirmCancelBookingEvent event,
    Emitter<CancelBookingState> emit,
  ) async {
    emit(
      state.copyWith(
        state: LoadState.loading,
      ),
    );
    DataState<CancelBookingModel> cancelBookingModel =
        await _bookingRepository.cancelBookingOrder(
      body: event.cancelBookingBody,
    );
    if (cancelBookingModel.isSuccess()) {
      emit(
        state.copyWith(
          state: LoadState.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          state: LoadState.failure,
        ),
      );
    }
  }
}
