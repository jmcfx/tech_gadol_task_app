import 'package:tech_gadol_task_app/src/core/enums/data_source.dart';
import 'package:tech_gadol_task_app/src/core/use_case/use_case.dart';
import 'package:tech_gadol_task_app/src/core/utils/type_def.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/entities/product_entity.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/repositories/product_repository.dart';

class GetProductsByCategory
    implements
        UseCase<(List<ProductEntity>, int, DataSource),
            GetProductsByCategoryParams> {
  final ProductRepository _repository;

  const GetProductsByCategory(this._repository);

  @override
  Future<FailureOr<(List<ProductEntity>, int, DataSource)>> call(
      GetProductsByCategoryParams params) {
    return _repository.getProductsByCategory(
      categorySlug: params.categorySlug,
      limit: params.limit,
      skip: params.skip,
    );
  }
}

class GetProductsByCategoryParams {
  final String categorySlug;
  final int limit;
  final int skip;

  const GetProductsByCategoryParams({
    required this.categorySlug,
    this.limit = 20,
    this.skip = 0,
  });
}
