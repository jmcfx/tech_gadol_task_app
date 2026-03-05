// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductResponseModel _$ProductResponseModelFromJson(
  Map<String, dynamic> json,
) => _ProductResponseModel(
  products:
      (json['products'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
  skip: (json['skip'] as num?)?.toInt() ?? 0,
  limit: (json['limit'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ProductResponseModelToJson(
  _ProductResponseModel instance,
) => <String, dynamic>{
  'products': instance.products,
  'total': instance.total,
  'skip': instance.skip,
  'limit': instance.limit,
};
