import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_gadol_task_app/src/core/di/injection_container.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/blocs/product_detail_cubit.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/blocs/product_list_bloc.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/blocs/product_list_event.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/pages/product_detail_screen.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/pages/responsive_product_layout.dart';

/// Centralized route configuration with GoRouter.
class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/products',
    routes: [
      GoRoute(path: '/', redirect: (_, _) => '/products'),
      GoRoute(
        path: '/products',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => sl<ProductListBloc>()..add(const FetchProducts()),
            child: const ResponsiveProductLayout(),
          );
        },
        routes: [
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
              return BlocProvider(
                create: (_) => sl<ProductDetailCubit>()..fetchProduct(id),
                child: const ProductDetailScreen(),
              );
            },
          ),
        ],
      ),
    ],
  );
}
