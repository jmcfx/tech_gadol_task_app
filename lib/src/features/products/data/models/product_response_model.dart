import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tech_gadol_task_app/src/features/products/data/models/product_model.dart';

part 'product_response_model.freezed.dart';
part 'product_response_model.g.dart';

/// Envelope model for paginated product API responses.
@freezed
sealed class ProductResponseModel with _$ProductResponseModel {
  const factory ProductResponseModel({
    @Default([]) List<ProductModel> products,
    @Default(0) int total,
    @Default(0) int skip,
    @Default(0) int limit,
  }) = _ProductResponseModel;

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseModelFromJson(json);
}
