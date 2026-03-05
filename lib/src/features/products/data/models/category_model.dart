import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

/// Represents a product category from the API.
@freezed
sealed class CategoryModel with _$CategoryModel {
  const factory CategoryModel({
    @Default('') String slug,
    @Default('') String name,
    @Default('') String url,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
