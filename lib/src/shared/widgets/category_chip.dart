import 'package:flutter/material.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_spacing.dart';

/// A selectable category filter chip with animated selection state.
class CategoryChip extends StatelessWidget {
  const CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
              border: Border.all(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline,
                width: 1.5,
              ),
            ),
            child: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
