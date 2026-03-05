import 'package:flutter/material.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_spacing.dart';

/// Displayed when a search or filter query returns no results.
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    this.message = 'No products found',
    this.subtitle = 'Try adjusting your search or filter criteria',
    super.key,
  });

  final String message;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: AppSpacing.paddingLg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 48,
                color: theme.colorScheme.primary.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              message,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
