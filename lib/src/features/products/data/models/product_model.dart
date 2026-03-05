import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
sealed class ProductModel with _$ProductModel {
  const factory ProductModel({
    @Default(0) int id,
    @Default('') String title,
    @Default('') String description,
    @Default(0.0) double price,
    @Default(0.0) double discountPercentage,
    @Default(0.0) double rating,
    @Default(0) int stock,
    String? brand,
    @Default('') String category,
    @Default('') String thumbnail,
    @Default([]) List<String> images,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
