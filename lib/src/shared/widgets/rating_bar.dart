import 'package:flutter/material.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_colors_extension.dart';

/// Displays a star rating (0‑5) with half‑star precision.
class RatingBar extends StatelessWidget {
  const RatingBar({
    required this.rating,
    this.starSize = 18,
    this.showLabel = true,
    super.key,
  });

  final double rating;
  final double starSize;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ext = theme.extension<AppColorsExtension>()!;
    final clampedRating = rating.clamp(0.0, 5.0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(5, (i) {
          final starValue = i + 1;
          IconData icon;
          Color color;

          if (clampedRating >= starValue) {
            icon = Icons.star_rounded;
            color = ext.starFilled;
          } else if (clampedRating >= starValue - 0.5) {
            icon = Icons.star_half_rounded;
            color = ext.starFilled;
          } else {
            icon = Icons.star_outline_rounded;
            color = ext.starEmpty;
          }

          return Icon(icon, size: starSize, color: color);
        }),
        if (showLabel) ...[
          const SizedBox(width: 4),
          Text(
            clampedRating.toStringAsFixed(1),
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}
