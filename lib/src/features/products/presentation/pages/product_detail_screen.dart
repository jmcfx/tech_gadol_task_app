import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_colors_extension.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_spacing.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/blocs/product_detail_cubit.dart';
import 'package:tech_gadol_task_app/src/shared/widgets/cached_product_image.dart';
import 'package:tech_gadol_task_app/src/shared/widgets/error_state_widget.dart';
import 'package:tech_gadol_task_app/src/shared/widgets/price_tag.dart';
import 'package:tech_gadol_task_app/src/shared/widgets/rating_bar.dart';

/// Product detail screen showing full product information:
/// image gallery, title, brand, description, price, rating, stock.
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailCubit, ProductDetailState>(
      builder: (context, state) {
        if (state.status.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        }

        if (state.status.isError) {
          return Scaffold(
            body: ErrorStateWidget(
              message: state.errorMessage ?? 'Failed to load product',
              onRetry: () {
                if (state.product != null) {
                  context.read<ProductDetailCubit>().fetchProduct(
                    state.product!.id,
                  );
                }
              },
            ),
          );
        }

        final product = state.product;
        if (product == null) {
          return const Scaffold(body: Center(child: Text('Product not found')));
        }

        final theme = Theme.of(context);

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // ── Image Gallery in SliverAppBar ──
              SliverAppBar(
                expandedHeight: 350,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: _ImageGallery(
                    images: product.images.isNotEmpty
                        ? product.images
                        : [product.thumbnail],
                    heroTag: 'product-image-${product.id}',
                  ),
                ),
              ),

              // ── Product details ──
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppSpacing.paddingMd,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm + 4,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(
                            AppSpacing.radiusSm,
                          ),
                        ),
                        child: Text(
                          product.category.toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      // Brand
                      Text(
                        product.safeBrand,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),

                      // Title
                      Text(
                        product.title,
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Rating
                      RatingBar(rating: product.rating, starSize: 22),
                      const SizedBox(height: AppSpacing.md),

                      // Price
                      PriceTag(
                        price: product.price,
                        discountPercentage: product.discountPercentage,
                        fontSize: 24,
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Stock availability
                      _StockBadge(
                        isInStock: product.isInStock,
                        stock: product.stock,
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Description header
                      Text(
                        'Description',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      // Description
                      Text(
                        product.description.isNotEmpty
                            ? product.description
                            : 'No description available.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Image Gallery ──

class _ImageGallery extends StatefulWidget {
  const _ImageGallery({required this.images, required this.heroTag});

  final List<String> images;
  final String heroTag;

  @override
  State<_ImageGallery> createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<_ImageGallery> {
  int _currentPage = 0;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Image pages
        PageView.builder(
          controller: _pageController,
          itemCount: widget.images.length,
          onPageChanged: (i) => setState(() => _currentPage = i),
          itemBuilder: (context, index) {
            final image = CachedProductImage(
              imageUrl: widget.images[index],
              fit: BoxFit.cover,
            );

            if (index == 0) {
              return Hero(tag: widget.heroTag, child: image);
            }
            return image;
          },
        ),

        // Dots indicator
        if (widget.images.length > 1)
          Positioned(
            bottom: AppSpacing.md,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentPage == i ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ── Stock Badge ──

class _StockBadge extends StatelessWidget {
  const _StockBadge({required this.isInStock, required this.stock});

  final bool isInStock;
  final int stock;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ext = theme.extension<AppColorsExtension>()!;

    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: isInStock ? ext.inStock : ext.outOfStock,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          isInStock ? 'In Stock ($stock available)' : 'Out of Stock',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isInStock ? ext.inStock : ext.outOfStock,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
