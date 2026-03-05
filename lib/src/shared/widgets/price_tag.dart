import 'package:flutter/material.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_colors_extension.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_spacing.dart';
import 'package:logger/logger.dart';

final _log = Logger(printer: PrettyPrinter(methodCount: 0));

/// Displays a price with optional discount.
///
/// When [discountPercentage] > 0, shows the discounted price in bold with the
/// original price struck through and a discount badge.
class PriceTag extends StatelessWidget {
  const PriceTag({
    required this.price,
    this.discountPercentage = 0,
    this.fontSize,
    super.key,
  });

  final double price;
  final double discountPercentage;
  final double? fontSize;

  bool get _isInvalid => price <= 0;
  bool get _hasDiscount => discountPercentage > 0 && !_isInvalid;

  double get _discountedPrice =>
      _hasDiscount ? price * (1 - discountPercentage / 100) : price;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ext = theme.extension<AppColorsExtension>()!;

    if (_isInvalid) {
      _log.e('Invalid price: $price — displaying "Price unavailable"');
      return Text(
        'Price unavailable',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.error,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '\$${_discountedPrice.toStringAsFixed(2)}',
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
        ),
        if (_hasDiscount) ...[
          const SizedBox(width: AppSpacing.sm),
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: theme.textTheme.bodySmall?.copyWith(
              decoration: TextDecoration.lineThrough,
              color: theme.colorScheme.onSurfaceVariant,
              decorationColor: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: ext.discount.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
            child: Text(
              '-${discountPercentage.toStringAsFixed(0)}%',
              style: theme.textTheme.labelSmall?.copyWith(
                color: ext.discount,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
