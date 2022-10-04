import 'package:passenger/features/booking_page/data/model/upsert_draft_booking_model.dart';

class DestinationItem {
  DestinationItem({this.model, this.index});
  int? index;
  LocationRequest? model;

  DestinationItem copyWith({int? index, LocationRequest? model}) =>
      DestinationItem(
        index: index ?? this.index,
        model: model ?? this.model,
      );
}
