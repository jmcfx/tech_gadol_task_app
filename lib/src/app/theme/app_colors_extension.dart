import 'package:flutter/material.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_colors.dart';

/// Custom [ThemeExtension] that injects semantic colors not covered by
/// the standard [ColorScheme] into the theme tree.
///
/// Access in widgets via:
/// ```dart
/// final ext = Theme.of(context).extension<AppColorsExtension>()!;
/// ext.discount // → rose color for sale badges
/// ```
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color discount;
  final Color discountBg;
  final Color starFilled;
  final Color starEmpty;
  final Color inStock;
  final Color outOfStock;
  final Color shimmerBase;
  final Color shimmerHighlight;
  final Color cacheBannerBg;
  final Color cacheBannerBorder;
  final Color cacheBannerFg;

  const AppColorsExtension({
    required this.discount,
    required this.discountBg,
    required this.starFilled,
    required this.starEmpty,
    required this.inStock,
    required this.outOfStock,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.cacheBannerBg,
    required this.cacheBannerBorder,
    required this.cacheBannerFg,
  });

  /// Light mode variant.
  static const light = AppColorsExtension(
    discount: AppColors.discount,
    discountBg: AppColors.discountBg,
    starFilled: AppColors.starFilled,
    starEmpty: AppColors.starEmpty,
    inStock: AppColors.inStock,
    outOfStock: AppColors.outOfStock,
    shimmerBase: AppColors.shimmerBase,
    shimmerHighlight: AppColors.shimmerHighlight,
    cacheBannerBg: AppColors.cacheBannerBgLight,
    cacheBannerBorder: AppColors.cacheBannerBorderLight,
    cacheBannerFg: AppColors.cacheBannerFgLight,
  );

  /// Dark mode variant.
  static const dark = AppColorsExtension(
    discount: AppColors.discount,
    discountBg: AppColors.discountBg,
    starFilled: AppColors.starFilled,
    starEmpty: AppColors.starEmpty,
    inStock: AppColors.inStock,
    outOfStock: AppColors.outOfStock,
    shimmerBase: AppColors.shimmerBaseDark,
    shimmerHighlight: AppColors.shimmerHighlightDark,
    cacheBannerBg: AppColors.cacheBannerBgDark,
    cacheBannerBorder: AppColors.cacheBannerBorderDark,
    cacheBannerFg: AppColors.cacheBannerFgDark,
  );

  @override
  AppColorsExtension copyWith({
    Color? discount,
    Color? discountBg,
    Color? starFilled,
    Color? starEmpty,
    Color? inStock,
    Color? outOfStock,
    Color? shimmerBase,
    Color? shimmerHighlight,
    Color? cacheBannerBg,
    Color? cacheBannerBorder,
    Color? cacheBannerFg,
  }) {
    return AppColorsExtension(
      discount: discount ?? this.discount,
      discountBg: discountBg ?? this.discountBg,
      starFilled: starFilled ?? this.starFilled,
      starEmpty: starEmpty ?? this.starEmpty,
      inStock: inStock ?? this.inStock,
      outOfStock: outOfStock ?? this.outOfStock,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
      cacheBannerBg: cacheBannerBg ?? this.cacheBannerBg,
      cacheBannerBorder: cacheBannerBorder ?? this.cacheBannerBorder,
      cacheBannerFg: cacheBannerFg ?? this.cacheBannerFg,
    );
  }

  @override
  AppColorsExtension lerp(AppColorsExtension? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      discount: Color.lerp(discount, other.discount, t)!,
      discountBg: Color.lerp(discountBg, other.discountBg, t)!,
      starFilled: Color.lerp(starFilled, other.starFilled, t)!,
      starEmpty: Color.lerp(starEmpty, other.starEmpty, t)!,
      inStock: Color.lerp(inStock, other.inStock, t)!,
      outOfStock: Color.lerp(outOfStock, other.outOfStock, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(shimmerHighlight, other.shimmerHighlight, t)!,
      cacheBannerBg: Color.lerp(cacheBannerBg, other.cacheBannerBg, t)!,
      cacheBannerBorder:
          Color.lerp(cacheBannerBorder, other.cacheBannerBorder, t)!,
      cacheBannerFg: Color.lerp(cacheBannerFg, other.cacheBannerFg, t)!,
    );
  }
}
