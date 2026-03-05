# Tech Gadol — Product Catalog App

A Flutter product catalog app with a custom design system, offline caching, and full light/dark theme support. Consumes the [DummyJSON Products API](https://dummyjson.com/products).

## Setup

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Or use the Makefile: `make fresh` (clean + pub get + build_runner + dart fix).

## Architecture

**Clean Architecture** with three layers:

- **Domain** — entities, repository contracts, use cases (pure Dart, no external deps)
- **Data** — Retrofit API client, Freezed models, Hive local cache, repository implementation
- **Presentation** — BLoC/Cubit state management, GoRouter navigation, design system widgets

### State Management

- `ProductListBloc` — paginated fetching, debounced search (500ms), category filtering
- `ProductDetailCubit` — single product fetch with instant in-memory display
- `ThemeCubit` — light/dark toggle

### Offline Support

**Online-first, cache-fallback** strategy using Hive:
1. Fetch from API → cache locally → return `DataSource.network`
2. API fails → serve Hive cache → return `DataSource.cache` + show amber banner
3. No cache → propagate error to UI

Cache uses a 15-minute TTL with composite keys for paginated queries.

### Design System

- 9 reusable widgets: `ProductCard`, `AppSearchBar`, `CategoryChip`, `RatingBar`, `PriceTag`, `ShimmerProductCard`, `ErrorStateWidget`, `EmptyStateWidget`, `CachedProductImage`
- All semantic colors injected via `ThemeExtension<AppColorsExtension>` — widgets access colors exclusively through `Theme.of(context)`
- Warm violet/rose/amber palette (light) and deep plum/lilac (dark)

## Testing

32 tests — all pass ✅

```bash
flutter test     # 32/32 pass
flutter analyze  # 0 issues
```

## What I'd Improve With More Time

- **Richer UI polish** — staggered list animations on first load, shared element transitions beyond Hero, micro-interactions on card hover/press, and a parallax effect on the detail screen image gallery
- **Component showcase screen** — a `/showcase` route displaying every design system component in all variants (default, selected, disabled, light, dark)
- **Pull-to-refresh** — `RefreshIndicator` so users can manually retry after regaining connectivity
- **Search within category** — client-side filtering since DummyJSON doesn't support combined search + category queries
- **Deeper test coverage** — repository tests, Hive cache tests, integration tests with mock server, and golden snapshot tests for visual regression
- **Accessibility** — `Semantics` labels, contrast audit, minimum 48×48 touch targets

## AI Tools Usage

AI (Claude) was used as a pair-programming assistant for architecture scaffolding, design system generation, and test creation. All output was reviewed and refined — including fixing type mismatches, dependency conflicts, and refactoring direct color references to use `ThemeExtension`.
