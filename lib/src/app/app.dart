import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_gadol_task_app/src/app/router/app_router.dart';
import 'package:tech_gadol_task_app/src/app/theme/app_theme.dart';
import 'package:tech_gadol_task_app/src/app/theme/theme_cubit.dart';
import 'package:tech_gadol_task_app/src/core/di/injection_container.dart';
import 'package:tech_gadol_task_app/src/shared/widgets/unfocus.dart';

class TechGadolTaskApp extends StatelessWidget {
  const TechGadolTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<ThemeCubit>(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return Unfocus(
            child: MaterialApp.router(
              title: 'Product Catalog',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              routerConfig: AppRouter.router,
            ),
          );
        },
      ),
    );
  }
}
