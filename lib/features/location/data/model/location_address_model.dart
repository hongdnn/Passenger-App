import 'package:passenger/features/favorite_location/data/model/favorite_location.dart';
import 'package:passenger/features/landing_page/data/model/booking_history_sort_by_time_model.dart';
import 'package:passenger/features/location/data/model/place_detail_model.dart';

class LocationAddressModel {
  factory LocationAddressModel.from(PlaceDetailModel? placeDetailModel) {
    return LocationAddressModel(
      formatAddress: placeDetailModel?.result?.formattedAddress ?? '',
      nameAddress: placeDetailModel?.result?.name ?? '',
      latitude: placeDetailModel?.result?.geometry?.location?.lat ?? 0.0,
      longitude: placeDetailModel?.result?.geometry?.location?.lng ?? 0.0,
      placeId: placeDetailModel?.result?.placeId ?? '',
      reference: placeDetailModel?.result?.reference ?? '',
    );
  }

  factory LocationAddressModel.fromFavoriteLocation(FavoriteLocation? item) {
    return LocationAddressModel(
      formatAddress: item?.address ?? '',
      nameAddress: item?.addressName ?? '',
      latitude: item?.latitude ?? 0.0,
      longitude: item?.longitude ?? 0.0,
      placeId: item?.googleId ?? '',
      reference: item?.referenceId ?? '',
    );
  }

  factory LocationAddressModel.fromFrequentLocation(
    BookingDataSortByTime? item,
  ) {
    return LocationAddressModel(
      formatAddress: item?.address ?? '',
      nameAddress: item?.addressName ?? '',
      latitude: item?.latitude ?? 0.0,
      longitude: item?.longitude ?? 0.0,
      placeId: item?.googleId ?? '',
      reference: item?.referenceId ?? '',
    );
  }

  LocationAddressModel({
    this.formatAddress,
    this.nameAddress,
    this.latitude,
    this.longitude,
    this.placeId,
    this.reference,
  });

  final String? formatAddress;
  final String? nameAddress;
  final double? latitude;
  final double? longitude;
  final String? placeId;
  final String? reference;
}
