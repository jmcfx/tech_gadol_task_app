import 'package:tech_gadol_task_app/src/core/enums/data_source.dart';
import 'package:tech_gadol_task_app/src/core/utils/type_def.dart';
import 'package:tech_gadol_task_app/src/features/products/data/models/category_model.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/entities/product_entity.dart';

/// Domain contract for the product repository.
abstract interface class ProductRepository {
  Future<FailureOr<(List<ProductEntity>, int total, DataSource source)>>
      getProducts({
    required int limit,
    required int skip,
  });

  Future<FailureOr<(List<ProductEntity>, int total, DataSource source)>>
      searchProducts({
    required String query,
    required int limit,
    required int skip,
  });

  Future<FailureOr<(List<CategoryModel>, DataSource source)>> getCategories();

  Future<FailureOr<(List<ProductEntity>, int total, DataSource source)>>
      getProductsByCategory({
    required String categorySlug,
    required int limit,
    required int skip,
  });

  Future<FailureOr<(ProductEntity, DataSource source)>> getProductById(int id);
}
