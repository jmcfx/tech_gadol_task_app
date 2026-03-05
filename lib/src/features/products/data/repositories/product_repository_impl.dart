import 'package:dartz/dartz.dart';
import 'package:tech_gadol_task_app/src/core/enums/data_source.dart';
import 'package:tech_gadol_task_app/src/core/utils/map_exception_to_failure.dart';
import 'package:tech_gadol_task_app/src/core/utils/type_def.dart';
import 'package:tech_gadol_task_app/src/features/products/data/data_sources/local/products_local_data_source.dart';
import 'package:tech_gadol_task_app/src/features/products/data/data_sources/remote/products_remote_data_source.dart';
import 'package:tech_gadol_task_app/src/features/products/data/models/category_model.dart';
import 'package:tech_gadol_task_app/src/features/products/data/models/product_model.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/entities/product_entity.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/repositories/product_repository.dart';

/// Repository implementation with **online‑first, cache‑fallback** strategy:
///
/// 1. Try fetching fresh data from the API.
/// 2. On success → cache the response locally, return with [DataSource.network].
/// 3. On failure → serve cached data if available, return with [DataSource.cache].
/// 4. If no cache exists either → return the original failure.
class ProductRepositoryImpl implements ProductRepository {
  final ProductsRemoteDataSource _remoteDataSource;
  final ProductsLocalDataSource _localDataSource;

  const ProductRepositoryImpl(this._remoteDataSource, this._localDataSource);

  // ── Helpers ──

  /// Build a composite cache key for paginated product queries.
  String _productsCacheKey(String prefix, int limit, int skip) =>
      '${prefix}_l${limit}_s$skip';

  // ── Products ──

  @override
  Future<FailureOr<(List<ProductEntity>, int, DataSource)>> getProducts({
    required int limit,
    required int skip,
  }) async {
    final cacheKey = _productsCacheKey('all', limit, skip);
    try {
      final response = await _remoteDataSource.getProducts(
        limit: limit,
        skip: skip,
      );
      // Cache on successful fetch
      await _localDataSource.cacheProducts(
        cacheKey: cacheKey,
        products: response.products,
        total: response.total,
      );
      return Right((
        _mapToEntities(response.products),
        response.total,
        DataSource.network,
      ));
    } catch (e) {
      // Fallback to cache
      final cached = _localDataSource.getCachedProducts(cacheKey);
      if (cached != null) {
        return Right((
          _mapToEntities(cached.products),
          cached.total,
          DataSource.cache,
        ));
      }
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<FailureOr<(List<ProductEntity>, int, DataSource)>> searchProducts({
    required String query,
    required int limit,
    required int skip,
  }) async {
    final cacheKey = _productsCacheKey('search_$query', limit, skip);
    try {
      final response = await _remoteDataSource.searchProducts(
        query: query,
        limit: limit,
        skip: skip,
      );
      await _localDataSource.cacheProducts(
        cacheKey: cacheKey,
        products: response.products,
        total: response.total,
      );
      return Right((
        _mapToEntities(response.products),
        response.total,
        DataSource.network,
      ));
    } catch (e) {
      final cached = _localDataSource.getCachedProducts(cacheKey);
      if (cached != null) {
        return Right((
          _mapToEntities(cached.products),
          cached.total,
          DataSource.cache,
        ));
      }
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<FailureOr<(List<CategoryModel>, DataSource)>> getCategories() async {
    try {
      final categories = await _remoteDataSource.getCategories();
      await _localDataSource.cacheCategories(categories);
      return Right((categories, DataSource.network));
    } catch (e) {
      final cached = _localDataSource.getCachedCategories();
      if (cached != null) {
        return Right((cached, DataSource.cache));
      }
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<FailureOr<(List<ProductEntity>, int, DataSource)>>
      getProductsByCategory({
    required String categorySlug,
    required int limit,
    required int skip,
  }) async {
    final cacheKey = _productsCacheKey('cat_$categorySlug', limit, skip);
    try {
      final response = await _remoteDataSource.getProductsByCategory(
        categorySlug: categorySlug,
        limit: limit,
        skip: skip,
      );
      await _localDataSource.cacheProducts(
        cacheKey: cacheKey,
        products: response.products,
        total: response.total,
      );
      return Right((
        _mapToEntities(response.products),
        response.total,
        DataSource.network,
      ));
    } catch (e) {
      final cached = _localDataSource.getCachedProducts(cacheKey);
      if (cached != null) {
        return Right((
          _mapToEntities(cached.products),
          cached.total,
          DataSource.cache,
        ));
      }
      return Left(mapExceptionToFailure(e));
    }
  }

  @override
  Future<FailureOr<(ProductEntity, DataSource)>> getProductById(int id) async {
    try {
      final model = await _remoteDataSource.getProductById(id);
      await _localDataSource.cacheProduct(model);
      return Right((_toEntity(model), DataSource.network));
    } catch (e) {
      final cached = _localDataSource.getCachedProduct(id);
      if (cached != null) {
        return Right((_toEntity(cached), DataSource.cache));
      }
      return Left(mapExceptionToFailure(e));
    }
  }

  // ── Mappers ──

  List<ProductEntity> _mapToEntities(List<ProductModel> models) =>
      models.map(_toEntity).toList();

  ProductEntity _toEntity(ProductModel m) => ProductEntity(
        id: m.id,
        title: m.title.isNotEmpty ? m.title : 'Untitled Product',
        description: m.description,
        price: m.price,
        discountPercentage: m.discountPercentage.clamp(0, 100),
        rating: m.rating.clamp(0, 5),
        stock: m.stock < 0 ? 0 : m.stock,
        brand: m.brand,
        category: m.category.isNotEmpty ? m.category : 'Uncategorized',
        thumbnail: m.thumbnail,
        images: m.images,
      );
}
