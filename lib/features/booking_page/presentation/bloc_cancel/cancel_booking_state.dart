part of 'cancel_booking_bloc.dart';

class CancelBookingState {
  CancelBookingState({this.idReason = -1, this.state});

  final LoadState? state;
  final int idReason;

  CancelBookingState copyWith({
    LoadState? state,
    int? idReason,
  }) {
    return CancelBookingState(
      state: state ?? this.state,
      idReason: idReason ?? this.idReason,
    );
  }
}
