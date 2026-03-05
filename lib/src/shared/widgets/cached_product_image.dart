import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_spacing.dart';
import 'package:logger/logger.dart';

final _log = Logger(printer: PrettyPrinter(methodCount: 0));

/// Wrapper around [CachedNetworkImage] with a consistent placeholder,
/// error fallback, and invalid-URL logging.
class CachedProductImage extends StatelessWidget {
  const CachedProductImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    super.key,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  bool get _isValidUrl {
    final uri = Uri.tryParse(imageUrl);
    return uri != null && uri.hasScheme && uri.host.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget image;
    if (!_isValidUrl || imageUrl.isEmpty) {
      _log.w('Invalid image URL: "$imageUrl" — showing placeholder');
      image = _placeholder(theme);
    } else {
      image = CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        placeholder: (_, _) => _shimmerPlaceholder(theme),
        errorWidget: (_, url, error) {
          _log.w('Failed to load image: $url');
          return _placeholder(theme);
        },
      );
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: image);
    }
    return image;
  }

  Widget _placeholder(ThemeData theme) {
    return Container(
      width: width,
      height: height,
      color: theme.colorScheme.outline.withValues(alpha: 0.15),
      child: Icon(
        Icons.image_outlined,
        size: 40,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _shimmerPlaceholder(ThemeData theme) {
    return Container(
      width: width,
      height: height,
      color: theme.colorScheme.outline.withValues(alpha: 0.1),
      child: Center(
        child: SizedBox(
          width: AppSpacing.lg,
          height: AppSpacing.lg,
          child: CircularProgressIndicator.adaptive(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary.withValues(alpha: 0.5)),
          ),
        ),
      ),
    );
  }
}
