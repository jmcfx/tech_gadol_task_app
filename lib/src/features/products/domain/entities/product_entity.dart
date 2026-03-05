import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String? brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  const ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  // ── Computed helpers for data validation ──────────────────

  /// Returns brand or 'Unknown brand' when null/empty.
  String get safeBrand =>
      (brand != null && brand!.isNotEmpty) ? brand! : 'Unknown brand';

  /// Whether the product has a meaningful discount.
  bool get hasDiscount => discountPercentage > 0 && price > 0;

  /// Price after applying the discount percentage.
  double get discountedPrice =>
      hasDiscount ? price * (1 - discountPercentage / 100) : price;

  /// Whether the price is valid (positive).
  bool get isPriceValid => price > 0;

  /// Whether the product is in stock.
  bool get isInStock => stock > 0;

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    price,
    discountPercentage,
    rating,
    stock,
    brand,
    category,
    thumbnail,
    images,
  ];
}
