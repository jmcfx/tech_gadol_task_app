import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_gadol_task_app/src/core/di/injection_container.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/entities/product_entity.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/blocs/product_detail_cubit.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/pages/product_detail_screen.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/pages/product_list_screen.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_spacing.dart';

/// Responsive layout that shows master-detail on wide screens
/// and standard push navigation on narrow screens.
class ResponsiveProductLayout extends StatefulWidget {
  const ResponsiveProductLayout({super.key});

  @override
  State<ResponsiveProductLayout> createState() =>
      _ResponsiveProductLayoutState();
}

class _ResponsiveProductLayoutState extends State<ResponsiveProductLayout> {
  ProductEntity? _selectedProduct;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth >= 768;

        if (isWideScreen) {
          return _buildMasterDetail(context);
        }

        return ProductListScreen(
          onProductTap: (product) {
            context.push('/products/${product.id}');
          },
        );
      },
    );
  }

  Widget _buildMasterDetail(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        // ── Left panel: Product List ──
        SizedBox(
          width: 380,
          child: ProductListScreen(
            onProductTap: (product) {
              setState(() => _selectedProduct = product);
            },
            selectedProductId: _selectedProduct?.id,
          ),
        ),
        // Vertical divider
        Container(
          width: 1,
          color: theme.colorScheme.outline.withValues(alpha: 0.3),
        ),
        // ── Right panel: Product Detail ──
        Expanded(
          child: _selectedProduct != null
              ? BlocProvider(
                  key: ValueKey(_selectedProduct!.id),
                  create: (_) =>
                      sl<ProductDetailCubit>()..showProduct(_selectedProduct!),
                  child: const ProductDetailScreen(),
                )
              : _buildEmptyDetail(theme),
        ),
      ],
    );
  }

  Widget _buildEmptyDetail(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.touch_app_outlined,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Select a product',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Choose a product from the list to view details',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
