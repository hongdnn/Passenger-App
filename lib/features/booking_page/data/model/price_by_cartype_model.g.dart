// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_by_cartype_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceByCarTypeModel _$PriceByCarTypeModelFromJson(Map<String, dynamic> json) =>
    PriceByCarTypeModel(
      resultCode: json['resultCode'] as int?,
      errorMessage: json['errorMessage'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PriceByCarTypeData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PriceByCarTypeModelToJson(
        PriceByCarTypeModel instance) =>
    <String, dynamic>{
      'resultCode': instance.resultCode,
      'errorMessage': instance.errorMessage,
      'data': instance.data,
    };

PriceByCarTypeData _$PriceByCarTypeDataFromJson(Map<String, dynamic> json) =>
    PriceByCarTypeData(
      category: json['category'] as String?,
      cars: (json['cars'] as List<dynamic>?)
          ?.map((e) => CarInfoByPrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PriceByCarTypeDataToJson(PriceByCarTypeData instance) =>
    <String, dynamic>{
      'category': instance.category,
      'cars': instance.cars,
    };

CarInfoByPrice _$CarInfoByPriceFromJson(Map<String, dynamic> json) =>
    CarInfoByPrice(
      driverTypeId: json['driverTypeId'] as int?,
      typeName: json['typeName'] as String?,
      typeSlogan: json['typeSlogan'] as String?,
      carImage: json['carImage'] as String?,
      carIcon: json['carIcon'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      orders: json['orders'] as int?,
      category: json['category'] as String?,
      demandRate: (json['demandRate'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CarInfoByPriceToJson(CarInfoByPrice instance) =>
    <String, dynamic>{
      'driverTypeId': instance.driverTypeId,
      'typeName': instance.typeName,
      'typeSlogan': instance.typeSlogan,
      'carImage': instance.carImage,
      'carIcon': instance.carIcon,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'price': instance.price,
      'orders': instance.orders,
      'category': instance.category,
      'demandRate': instance.demandRate,
    };

GetPriceRequestBody _$GetPriceRequestBodyFromJson(Map<String, dynamic> json) =>
    GetPriceRequestBody(
      depLat: (json['dep_lat'] as num?)?.toDouble(),
      depLng: (json['dep_lng'] as num?)?.toDouble(),
      desLat: (json['des_lat'] as num?)?.toDouble(),
      desLng: (json['des_lng'] as num?)?.toDouble(),
      distance: json['distance'] as int?,
    );

Map<String, dynamic> _$GetPriceRequestBodyToJson(
        GetPriceRequestBody instance) =>
    <String, dynamic>{
      'dep_lat': instance.depLat,
      'dep_lng': instance.depLng,
      'des_lat': instance.desLat,
      'des_lng': instance.desLng,
      'distance': instance.distance,
    };
