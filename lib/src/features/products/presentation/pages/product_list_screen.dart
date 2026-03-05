import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_colors_extension.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_spacing.dart';
import 'package:tech_gadol_task_app/src/core/enums/data_source.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/entities/product_entity.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/blocs/product_list_bloc.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/blocs/product_list_event.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/blocs/product_list_state.dart';
import 'package:tech_gadol_task_app/src/shared/widgets/app_search_bar.dart';
import 'package:tech_gadol_task_app/src/shared/widgets/category_chip.dart';
import 'package:tech_gadol_task_app/src/shared/widgets/empty_state_widget.dart';
import 'package:tech_gadol_task_app/src/shared/widgets/error_state_widget.dart';
import 'package:tech_gadol_task_app/src/shared/widgets/product_card.dart';
import 'package:tech_gadol_task_app/src/shared/widgets/shimmer_product_card.dart';
import 'package:tech_gadol_task_app/src/app/theme/theme_cubit.dart';

/// Product list screen with search, category filters, infinite scroll,
/// and all loading/error/empty states.
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({
    required this.onProductTap,
    this.selectedProductId,
    super.key,
  });

  final ValueChanged<ProductEntity> onProductTap;
  final int? selectedProductId;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ProductListBloc>().add(const LoadMoreProducts());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 200);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalog'),
        actions: [
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return IconButton(
                icon: Icon(
                  themeMode == ThemeMode.dark
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                ),
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                tooltip: 'Toggle theme',
              );
            },
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              // ── Search bar ──
              SliverToBoxAdapter(
                child: AppSearchBar(
                  onChanged: (query) {
                    context.read<ProductListBloc>().add(
                      SearchQueryChanged(query),
                    );
                  },
                ),
              ),

              // ── Category chips ──
              if (state.categories.isNotEmpty)
                SliverToBoxAdapter(
                  child: SizedBox(
                   height: 48,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      itemCount: state.categories.length,
                      separatorBuilder: (_, _) =>
                          const SizedBox(width: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        final cat = state.categories[index];
                        return CategoryChip(
                          label: cat.name,
                          isSelected: state.selectedCategory == cat.slug,
                          onTap: () {
                            context.read<ProductListBloc>().add(
                              CategorySelected(cat.slug),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),

              // ── Cache indicator ──
              if (state.dataSource == DataSource.cache &&
                  state.products.isNotEmpty)
                SliverToBoxAdapter(
                  child: _CacheBanner(),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),

              // ── Content ──
              _buildContent(state, theme),

              // ── Bottom loading indicator ──
              if (state.paginationStatus.isLoading)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.lg),
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  ),
                ),

              // Bottom padding
              const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(ProductListState state, ThemeData theme) {
    // Initial loading
    if (state.status.isLoading && state.products.isEmpty) {
      return const ShimmerProductGrid();
    }

    // Error
    if (state.status.isError && state.products.isEmpty) {
      return SliverFillRemaining(
        child: ErrorStateWidget(
          message: state.errorMessage ?? 'Failed to load products',
          onRetry: () =>
              context.read<ProductListBloc>().add(const RetryFetch()),
        ),
      );
    }

    // Empty
    if (state.status.isSuccess && state.products.isEmpty) {
      return const SliverFillRemaining(child: EmptyStateWidget());
    }

    // Product list
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final product = state.products[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: ProductCard(
              product: product,
              isSelected: widget.selectedProductId == product.id,
              onTap: () => widget.onProductTap(product),
            ),
          );
        }, childCount: state.products.length),
      ),
    );
  }
}

// ── Cache Indicator Banner ──

class _CacheBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ext = theme.extension<AppColorsExtension>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: ext.cacheBannerBg,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          border: Border.all(
            color: ext.cacheBannerBorder,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 16,
              color: ext.cacheBannerFg,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              'Showing cached data — pull to refresh when online',
              style: theme.textTheme.labelMedium?.copyWith(
                color: ext.cacheBannerFg,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
