import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_colors.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_colors_extension.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_spacing.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_text_styles.dart';

/// Provides [ThemeData] for light and dark modes using the design system tokens.
class AppTheme {
  AppTheme._();

  // ── Light ──────────────────────────────────────────────────
  static ThemeData get lightTheme {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryLight,
      onPrimary: AppColors.onPrimaryLight,
      primaryContainer: AppColors.primaryContainerLight,
      onPrimaryContainer: AppColors.primaryLight,
      secondary: AppColors.secondaryLight,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.secondaryContainerLight,
      onSecondaryContainer: AppColors.secondaryLight,
      tertiary: AppColors.tertiaryLight,
      onTertiary: Colors.white,
      error: AppColors.errorLight,
      onError: Colors.white,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.onSurfaceLight,
      onSurfaceVariant: AppColors.onSurfaceVariantLight,
      surfaceContainerHighest: AppColors.surfaceContainerLight,
      outline: AppColors.outlineLight,
      outlineVariant: AppColors.outlineVariantLight,
      shadow: Color(0x1A7C3AED), // Violet‑tinted shadow for premium feel
    );

    return _buildTheme(colorScheme, Brightness.light);
  }

  // ── Dark ───────────────────────────────────────────────────
  static ThemeData get darkTheme {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.primaryDark,
      onPrimary: AppColors.onPrimaryDark,
      primaryContainer: AppColors.primaryContainerDark,
      onPrimaryContainer: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      onSecondary: Color(0xFF1E1B2E),
      secondaryContainer: AppColors.secondaryContainerDark,
      onSecondaryContainer: AppColors.secondaryDark,
      tertiary: AppColors.tertiaryDark,
      onTertiary: Color(0xFF1E1B2E),
      error: AppColors.errorDark,
      onError: Color(0xFF1E1B2E),
      surface: AppColors.surfaceDark,
      onSurface: AppColors.onSurfaceDark,
      onSurfaceVariant: AppColors.onSurfaceVariantDark,
      surfaceContainerHighest: AppColors.surfaceContainerDark,
      outline: AppColors.outlineDark,
      outlineVariant: AppColors.outlineVariantDark,
      shadow: Color(0x40000000),
    );

    return _buildTheme(colorScheme, Brightness.dark);
  }

  // ── Shared builder ─────────────────────────────────────────
  static ThemeData _buildTheme(ColorScheme scheme, Brightness brightness) {
    final isLight = brightness == Brightness.light;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor:
          isLight ? AppColors.backgroundLight : AppColors.backgroundDark,
      textTheme: AppTextStyles.textTheme.apply(
        bodyColor: scheme.onSurface,
        displayColor: scheme.onSurface,
      ),

      // ── Custom color extension ──
      extensions: [
        isLight ? AppColorsExtension.light : AppColorsExtension.dark,
      ],

      // ── AppBar ──
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        backgroundColor:
            isLight ? AppColors.backgroundLight : AppColors.backgroundDark,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: isLight
            ? SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: AppColors.backgroundLight,
              )
            : SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: AppColors.backgroundDark,
              ),
        titleTextStyle: AppTextStyles.textTheme.titleLarge?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),

      // ── Card ──
      cardTheme: CardThemeData(
        elevation: isLight ? 0 : 0,
        shadowColor: scheme.shadow,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: BorderSide(
            color: isLight
                ? scheme.outline.withValues(alpha: 0.6)
                : scheme.outline.withValues(alpha: 0.3),
          ),
        ),
        color: scheme.surface,
        margin: EdgeInsets.zero,
      ),

      // ── Chip ──
      chipTheme: ChipThemeData(
        backgroundColor: isLight
            ? scheme.surfaceContainerHighest
            : scheme.surfaceContainerHighest,
        selectedColor: scheme.primary,
        labelStyle: AppTextStyles.textTheme.labelLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        ),
        side: BorderSide(
          color: isLight
              ? scheme.outline.withValues(alpha: 0.5)
              : scheme.outline.withValues(alpha: 0.3),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        showCheckmark: false,
      ),

      // ── Input ──
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isLight
            ? AppColors.surfaceContainerLight
            : AppColors.surfaceContainerDark,
        hintStyle: AppTextStyles.textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm + 4,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
      ),

      // ── ElevatedButton ──
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm + 4,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          textStyle: AppTextStyles.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ── IconButton ──
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: scheme.onSurfaceVariant,
        ),
      ),

      // ── ProgressIndicator ──
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.outline.withValues(alpha: 0.3),
      ),

      // ── Divider ──
      dividerTheme: DividerThemeData(
        color: scheme.outline.withValues(alpha: 0.4),
        thickness: 1,
        space: 0,
      ),

      // ── Scrollbar ──
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStatePropertyAll(
          scheme.primary.withValues(alpha: 0.3),
        ),
        radius: const Radius.circular(4),
      ),

      // ── Page transitions ──
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
