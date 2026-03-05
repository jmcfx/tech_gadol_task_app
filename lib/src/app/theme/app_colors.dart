import 'package:flutter/material.dart';

/// Curated color palette for the Tech Gadol design system.
/// All components derive colors from the active [ThemeData.colorScheme]
/// at runtime — these constants seed the light/dark schemes.
class AppColors {
  AppColors._();

  // ══════════════════════════════════════════════════════════════
  //  LIGHT MODE — Warm violet primary, rose accent, amber tertiary
  // ══════════════════════════════════════════════════════════════
  static const Color primaryLight = Color(0xFF7C3AED);       // Violet‑600
  static const Color primaryContainerLight = Color(0xFFF3E8FF); // Soft violet tint
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color secondaryLight = Color(0xFFE11D48);     // Rose‑600
  static const Color secondaryContainerLight = Color(0xFFFFF1F2);
  static const Color tertiaryLight = Color(0xFFF59E0B);      // Amber‑500
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceContainerLight = Color(0xFFFAF5FF); // Faint violet wash
  static const Color backgroundLight = Color(0xFFFCFAFF);    // Warm white
  static const Color errorLight = Color(0xFFDC2626);         // Red‑600
  static const Color onSurfaceLight = Color(0xFF1C1917);     // Stone‑900
  static const Color onSurfaceVariantLight = Color(0xFF78716C); // Stone‑500
  static const Color outlineLight = Color(0xFFE7E5E4);       // Stone‑200
  static const Color outlineVariantLight = Color(0xFFF5F5F4); // Subtle separator

  // ══════════════════════════════════════════════════════════════
  //  DARK MODE — Deep plum with soft lilac glow
  // ══════════════════════════════════════════════════════════════
  static const Color primaryDark = Color(0xFFC4B5FD);        // Soft lilac
  static const Color primaryContainerDark = Color(0xFF4C1D95); // Deep violet core
  static const Color onPrimaryDark = Color(0xFF2E1065);      // Dark ink on primary
  static const Color secondaryDark = Color(0xFFFDA4AF);      // Soft rose
  static const Color secondaryContainerDark = Color(0xFF9F1239);
  static const Color tertiaryDark = Color(0xFFFCD34D);       // Warm gold
  static const Color surfaceDark = Color(0xFF1C1620);        // Deep plum
  static const Color surfaceContainerDark = Color(0xFF261E2D); // Lifted plum
  static const Color backgroundDark = Color(0xFF110D14);     // Near‑black purple
  static const Color errorDark = Color(0xFFFB7185);          // Rose‑400
  static const Color onSurfaceDark = Color(0xFFFAF5FF);      // Warm white
  static const Color onSurfaceVariantDark = Color(0xFFA8A29E); // Stone‑400
  static const Color outlineDark = Color(0xFF3D3347);         // Plum border
  static const Color outlineVariantDark = Color(0xFF231C29);  // Subtle separator

  // ══════════════════════════════════════════════════════════════
  //  SEMANTIC — Consistent meaning across both themes
  // ══════════════════════════════════════════════════════════════
  static const Color discount = Color(0xFFF43F5E);     // Rose‑500 — sale badge
  static const Color discountBg = Color(0x1AF43F5E);   // 10% rose overlay
  static const Color starFilled = Color(0xFFFBBF24);   // Amber‑400
  static const Color starEmpty = Color(0xFFCBD5E1);    // Slate‑300
  static const Color inStock = Color(0xFF10B981);      // Emerald‑500
  static const Color outOfStock = Color(0xFFF43F5E);   // Rose‑500
  static const Color shimmerBase = Color(0xFFE7E5E4);
  static const Color shimmerHighlight = Color(0xFFFAF5FF);
  static const Color shimmerBaseDark = Color(0xFF261E2D);
  static const Color shimmerHighlightDark = Color(0xFF3D3347);

  // ── Cache banner ──
  static const Color cacheBannerBgLight = Color(0xFFFEF3C7);     // Amber‑100
  static const Color cacheBannerBgDark = Color(0xFF451A03);      // Amber‑950
  static const Color cacheBannerBorderLight = Color(0xFFFDE68A); // Amber‑200
  static const Color cacheBannerBorderDark = Color(0xFF92400E);  // Amber‑800
  static const Color cacheBannerFgLight = Color(0xFF92400E);     // Amber‑800
  static const Color cacheBannerFgDark = Color(0xFFFCD34D);      // Amber‑300
}
