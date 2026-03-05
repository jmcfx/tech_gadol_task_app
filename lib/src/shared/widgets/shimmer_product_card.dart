import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_spacing.dart';

/// Skeleton loading placeholder that matches the [ProductCard] layout.
class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image placeholder
            Container(height: 180, width: double.infinity, color: Colors.white),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm + 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Brand
                  Container(
                    height: 10,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  // Title line 1
                  Container(
                    height: 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  // Title line 2
                  Container(
                    height: 14,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  // Rating
                  Container(
                    height: 16,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  // Price
                  Container(
                    height: 16,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
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

/// A grid of shimmer placeholders for the initial loading state.
class ShimmerProductGrid extends StatelessWidget {
  const ShimmerProductGrid({this.itemCount = 6, super.key});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, _) => const Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.md),
            child: ShimmerProductCard(),
          ),
          childCount: itemCount,
        ),
      ),
    );
  }
}
