import 'package:json_annotation/json_annotation.dart';

part 'list_car_location_request.g.dart';

@JsonSerializable()
class ListCarLocationRequest {
  factory ListCarLocationRequest.fromJson(Map<String, dynamic> json) =>
      _$ListCarLocationRequestFromJson(json);
  ListCarLocationRequest({
    required this.depLat,
    required this.depLng,
    required this.desLat,
    required this.desLng,
    required this.distance,
  });

  @JsonKey(name: 'dep_lat')
  final double depLat;

  @JsonKey(name: 'dep_lng')
  final double depLng;

  @JsonKey(name: 'des_lat')
  final double desLat;

  @JsonKey(name: 'des_lng')
  final double desLng;

  @JsonKey(name: 'distance')
  final double distance;

  Map<String, dynamic> toJson() => _$ListCarLocationRequestToJson(this);
}
