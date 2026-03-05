import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tech_gadol_task_app/src/app/theme/theme_cubit.dart';
import 'package:tech_gadol_task_app/src/features/products/data/clients/product_client.dart';
import 'package:tech_gadol_task_app/src/features/products/data/data_sources/local/products_local_data_source.dart';
import 'package:tech_gadol_task_app/src/features/products/data/data_sources/remote/products_remote_data_source.dart';
import 'package:tech_gadol_task_app/src/features/products/data/repositories/product_repository_impl.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/repositories/product_repository.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/use_cases/get_categories.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/use_cases/get_product_by_id.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/use_cases/get_products.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/use_cases/get_products_by_category.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/use_cases/search_products.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/blocs/product_list_bloc.dart';
import 'package:tech_gadol_task_app/src/features/products/presentation/blocs/product_detail_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // ── External ──
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ));
    dio.interceptors.add(
      LogInterceptor(requestBody: false, responseBody: false, logPrint: (o) {}),
    );
    return dio;
  });

  // ── Local Data Source (Hive) ──
  final localDataSource = ProductsLocalDataSource();
  await localDataSource.init();
  sl.registerLazySingleton<ProductsLocalDataSource>(() => localDataSource);

  // ── Clients ──
  sl.registerLazySingleton<ProductClient>(() => ProductClient(sl()));

  // ── Data Sources ──
  sl.registerLazySingleton<ProductsRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl()),
  );

  // ── Repositories ──
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl(), sl()),
  );

  // ── Use Cases ──
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => SearchProducts(sl()));
  sl.registerLazySingleton(() => GetCategories(sl()));
  sl.registerLazySingleton(() => GetProductById(sl()));
  sl.registerLazySingleton(() => GetProductsByCategory(sl()));

  // ── Blocs / Cubits ──
  sl.registerFactory(() => ProductListBloc(
        getProducts: sl(),
        searchProducts: sl(),
        getCategories: sl(),
        getProductsByCategory: sl(),
      ));

  sl.registerFactory(() => ProductDetailCubit(getProductById: sl()));

  sl.registerLazySingleton(() => ThemeCubit());
}
