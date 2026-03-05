import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tech_gadol_task_app/src/features/products/data/models/category_model.dart';
import 'package:tech_gadol_task_app/src/features/products/data/models/product_model.dart';

/// Local data source backed by Hive.
///
/// **Cache invalidation strategy**: Time‑based (TTL).
/// Each cached entry stores a timestamp. Data older than [cacheDuration]
/// is considered stale and will trigger a fresh API call, but stale data
/// is still returned as fallback if the network call fails.
///
/// **Why Hive?**
/// - Pure Dart, no native dependencies — works on all Flutter targets
/// - Very fast key‑value reads (no SQL overhead for simple K/V caching)
/// - Lightweight — no code generation required for basic usage
/// - Async‑friendly with lazy box opening
class ProductsLocalDataSource {
  static const String _productsBoxName = 'products_cache';
  static const String _categoriesBoxName = 'categories_cache';
  static const String _metaBoxName = 'cache_meta';

  /// Default cache TTL: 15 minutes.
  static const Duration cacheDuration = Duration(minutes: 15);

  late Box<String> _productsBox;
  late Box<String> _categoriesBox;
  late Box<String> _metaBox;

  /// Initialize Hive and open required boxes.
  Future<void> init() async {
    await Hive.initFlutter();
    _productsBox = await Hive.openBox<String>(_productsBoxName);
    _categoriesBox = await Hive.openBox<String>(_categoriesBoxName);
    _metaBox = await Hive.openBox<String>(_metaBoxName);
  }

  // ── Products ──

  /// Cache a list of products under a composite key.
  Future<void> cacheProducts({
    required String cacheKey,
    required List<ProductModel> products,
    required int total,
  }) async {
    final payload = jsonEncode({
      'products': products.map((p) => p.toJson()).toList(),
      'total': total,
    });
    await _productsBox.put(cacheKey, payload);
    await _metaBox.put(
      'ts_$cacheKey',
      DateTime.now().toIso8601String(),
    );
  }

  /// Retrieve cached products. Returns `null` if no cache exists.
  ({List<ProductModel> products, int total})? getCachedProducts(
      String cacheKey) {
    final raw = _productsBox.get(cacheKey);
    if (raw == null) return null;

    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final products = (map['products'] as List)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return (products: products, total: map['total'] as int);
    } catch (_) {
      // Corrupted cache — delete it
      _productsBox.delete(cacheKey);
      return null;
    }
  }

  // ── Categories ──

  Future<void> cacheCategories(List<CategoryModel> categories) async {
    final payload =
        jsonEncode(categories.map((c) => c.toJson()).toList());
    await _categoriesBox.put('all_categories', payload);
    await _metaBox.put(
      'ts_all_categories',
      DateTime.now().toIso8601String(),
    );
  }

  List<CategoryModel>? getCachedCategories() {
    final raw = _categoriesBox.get('all_categories');
    if (raw == null) return null;

    try {
      final list = jsonDecode(raw) as List;
      return list
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      _categoriesBox.delete('all_categories');
      return null;
    }
  }

  // ── Single product ──

  Future<void> cacheProduct(ProductModel product) async {
    await _productsBox.put(
      'product_${product.id}',
      jsonEncode(product.toJson()),
    );
  }

  ProductModel? getCachedProduct(int id) {
    final raw = _productsBox.get('product_$id');
    if (raw == null) return null;

    try {
      return ProductModel.fromJson(
          jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      _productsBox.delete('product_$id');
      return null;
    }
  }

  // ── Cache freshness ──

  /// Whether the cached data for [cacheKey] is still within the TTL window.
  bool isCacheFresh(String cacheKey) {
    final tsRaw = _metaBox.get('ts_$cacheKey');
    if (tsRaw == null) return false;

    try {
      final ts = DateTime.parse(tsRaw);
      return DateTime.now().difference(ts) < cacheDuration;
    } catch (_) {
      return false;
    }
  }

  /// Clear all cached data.
  Future<void> clearAll() async {
    await _productsBox.clear();
    await _categoriesBox.clear();
    await _metaBox.clear();
  }
}
