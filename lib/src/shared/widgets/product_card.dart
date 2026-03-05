import 'package:flutter/material.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_colors_extension.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_spacing.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/entities/product_entity.dart';
import 'package:tech_gadol_task_app/src/shared/widgets/cached_product_image.dart';
import 'package:tech_gadol_task_app/src/shared/widgets/price_tag.dart';
import 'package:tech_gadol_task_app/src/shared/widgets/rating_bar.dart';

/// Displays a product in a visually rich card with thumbnail, title, brand,
/// price (with discount), and rating.
class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    required this.onTap,
    this.isSelected = false,
    super.key,
  });

  final ProductEntity product;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ext = theme.extension<AppColorsExtension>()!;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        side: BorderSide(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.outline.withValues(alpha: 0.5),
          width: isSelected ? 2 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Thumbnail ──
            Stack(
              children: [
                Hero(
                  tag: 'product-image-${product.id}',
                  child: CachedProductImage(
                    imageUrl: product.thumbnail,
                    height: 180,
                    width: double.infinity,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppSpacing.radiusMd),
                    ),
                  ),
                ),
                // Discount badge
                if (product.hasDiscount)
                  Positioned(
                    top: AppSpacing.sm,
                    left: AppSpacing.sm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: ext.discount,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusSm,
                        ),
                      ),
                      child: Text(
                        '-${product.discountPercentage.toStringAsFixed(0)}%',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                // Stock badge
                Positioned(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    decoration: BoxDecoration(
                      color: product.isInStock
                          ? ext.inStock.withValues(alpha: 0.9)
                          : ext.outOfStock.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                    ),
                    child: Text(
                      product.isInStock ? 'In Stock' : 'Out of Stock',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ── Details ──
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm + 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand
                  Text(
                    product.safeBrand,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),

                  // Title
                  Text(
                    product.title,
                    style: theme.textTheme.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.sm),

                  // Rating
                  RatingBar(rating: product.rating, starSize: 16),
                  const SizedBox(height: AppSpacing.sm),

                  // Price
                  PriceTag(
                    price: product.price,
                    discountPercentage: product.discountPercentage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
