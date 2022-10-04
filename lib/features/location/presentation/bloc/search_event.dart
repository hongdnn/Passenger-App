part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchAutoCompleteEvent extends SearchEvent {
  SearchAutoCompleteEvent(this.keyword);

  final String keyword;
}

class GetFavoriteLocationsEvent extends SearchEvent {
  GetFavoriteLocationsEvent();
}

class DeleteFavoriteLocationEvent extends SearchEvent {
  DeleteFavoriteLocationEvent({required this.locationId});
  final String locationId;
}

class GetPlaceDetailEvent extends SearchEvent {
  GetPlaceDetailEvent(this.placeId);

  final String placeId;
}

class AddFavoriteLocationEvent extends SearchEvent {
  AddFavoriteLocationEvent({
    required this.favoriteLocation,
  });
  final FavoriteLocation favoriteLocation;
}

class UpdateFavoriteLocationEvent extends SearchEvent {
  UpdateFavoriteLocationEvent({
    required this.favoriteLocation,
  });
  final FavoriteLocation favoriteLocation;
}

class GetAddressFromLatLngEvent extends SearchEvent {
  GetAddressFromLatLngEvent({
    this.latitude,
    this.longitude,
  });
  final double? latitude;
  final double? longitude;
}

class GetUserCurrentLocationEvent extends SearchEvent {
  GetUserCurrentLocationEvent();
}

class GetCurrentLocationEvent extends SearchEvent {}
