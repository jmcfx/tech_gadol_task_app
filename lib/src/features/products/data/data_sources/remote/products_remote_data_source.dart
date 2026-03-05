import 'package:tech_gadol_task_app/src/features/products/data/clients/product_client.dart';
import 'package:tech_gadol_task_app/src/features/products/data/models/category_model.dart';
import 'package:tech_gadol_task_app/src/features/products/data/models/product_model.dart';
import 'package:tech_gadol_task_app/src/features/products/data/models/product_response_model.dart';

/// Contract for remote product data operations.
abstract interface class ProductsRemoteDataSource {
  Future<ProductResponseModel> getProducts({
    required int limit,
    required int skip,
  });

  Future<ProductResponseModel> searchProducts({
    required String query,
    required int limit,
    required int skip,
  });

  Future<List<CategoryModel>> getCategories();

  Future<ProductResponseModel> getProductsByCategory({
    required String categorySlug,
    required int limit,
    required int skip,
  });

  Future<ProductModel> getProductById(int id);
}

/// Implementation delegating to the Retrofit [ProductClient].
class ProductRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final ProductClient _client;

  const ProductRemoteDataSourceImpl(this._client);

  @override
  Future<ProductResponseModel> getProducts({
    required int limit,
    required int skip,
  }) => _client.getProducts(limit, skip);

  @override
  Future<ProductResponseModel> searchProducts({
    required String query,
    required int limit,
    required int skip,
  }) => _client.searchProducts(query, limit, skip);

  @override
  Future<List<CategoryModel>> getCategories() => _client.getCategories();

  @override
  Future<ProductResponseModel> getProductsByCategory({
    required String categorySlug,
    required int limit,
    required int skip,
  }) => _client.getProductsByCategory(categorySlug, limit, skip);

  @override
  Future<ProductModel> getProductById(int id) => _client.getProductById(id);
}
