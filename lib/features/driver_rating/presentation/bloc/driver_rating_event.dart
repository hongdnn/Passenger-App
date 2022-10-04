part of 'driver_rating_bloc.dart';

@immutable
abstract class DriverRatingEvent {}

class InitializeRating extends DriverRatingEvent {
  InitializeRating({required this.bookingId});
  final String bookingId;
}

class SelectStarEvent extends DriverRatingEvent {
  SelectStarEvent(this.rating);

  final int rating;
}

class SelectReasonEvent extends DriverRatingEvent {
  SelectReasonEvent(this.reason);

  final String reason;
}

class SelectTipEvent extends DriverRatingEvent {
  SelectTipEvent(this.tip);

  final num tip;
}

class CommentEvent extends DriverRatingEvent {
  CommentEvent(this.text);

  final String? text;
}

class ConfirmRatingEvent extends DriverRatingEvent {
  ConfirmRatingEvent({required this.ratingRequest});
  final RateDriverRequest ratingRequest;
}
