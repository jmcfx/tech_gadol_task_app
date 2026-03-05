import 'package:tech_gadol_task_app/src/core/enums/data_source.dart';
import 'package:tech_gadol_task_app/src/core/use_case/use_case.dart';
import 'package:tech_gadol_task_app/src/core/utils/type_def.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/entities/product_entity.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/repositories/product_repository.dart';

class SearchProducts
    implements
        UseCase<(List<ProductEntity>, int, DataSource), SearchProductsParams> {
  final ProductRepository _repository;

  const SearchProducts(this._repository);

  @override
  Future<FailureOr<(List<ProductEntity>, int, DataSource)>> call(
      SearchProductsParams params) {
    return _repository.searchProducts(
      query: params.query,
      limit: params.limit,
      skip: params.skip,
    );
  }
}

class SearchProductsParams {
  final String query;
  final int limit;
  final int skip;

  const SearchProductsParams({
    required this.query,
    this.limit = 20,
    this.skip = 0,
  });
}
