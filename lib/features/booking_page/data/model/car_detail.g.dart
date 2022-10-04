// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarDescription _$CarDescriptionFromJson(Map<String, dynamic> json) =>
    CarDescription(
      resultCode: json['resultCode'] as int?,
      errorMessage: json['errorMessage'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CarInformation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarDescriptionToJson(CarDescription instance) =>
    <String, dynamic>{
      'resultCode': instance.resultCode,
      'errorMessage': instance.errorMessage,
      'data': instance.data,
    };

CarBodyRequest _$CarBodyRequestFromJson(Map<String, dynamic> json) =>
    CarBodyRequest(
      carTypeIds: (json['carTypeIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CarBodyRequestToJson(CarBodyRequest instance) =>
    <String, dynamic>{
      'carTypeIds': instance.carTypeIds,
    };

CarInformation _$CarInformationFromJson(Map<String, dynamic> json) =>
    CarInformation(
      typeId: json['type_id'] as int?,
      typeName: json['type_name'] as String?,
      typeSlogan: json['type_slogan'] as String?,
      typeDescription: json['type_description'] as String?,
      carImage: json['car_image'] as String?,
      carIcon: json['car_icon'] as String?,
      longitude: json['longitude'] as String?,
      latitude: json['latitude'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      orders: json['orders'] as int?,
      category: json['category'] as String?,
      categoryId: json['category_id'] as int?,
      listPrice: (json['list_price'] as List<dynamic>?)
          ?.map((e) => ListPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarInformationToJson(CarInformation instance) =>
    <String, dynamic>{
      'type_id': instance.typeId,
      'type_name': instance.typeName,
      'type_slogan': instance.typeSlogan,
      'type_description': instance.typeDescription,
      'car_image': instance.carImage,
      'car_icon': instance.carIcon,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'price': instance.price,
      'orders': instance.orders,
      'category': instance.category,
      'category_id': instance.categoryId,
      'list_price': instance.listPrice,
    };

ListPrice _$ListPriceFromJson(Map<String, dynamic> json) => ListPrice(
      label: json['label'] as int?,
      minDistance: json['min_distance'] as int?,
      maxDistance: json['max_distance'] as int?,
      price: json['price'] as num?,
      currency: json['currency'] as String?,
      orders: json['orders'] as int?,
      typeId: json['type_id'] as int?,
    );

Map<String, dynamic> _$ListPriceToJson(ListPrice instance) => <String, dynamic>{
      'label': instance.label,
      'min_distance': instance.minDistance,
      'max_distance': instance.maxDistance,
      'price': instance.price,
      'currency': instance.currency,
      'orders': instance.orders,
      'type_id': instance.typeId,
    };
