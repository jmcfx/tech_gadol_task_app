import 'package:tech_gadol_task_app/src/core/enums/data_source.dart';
import 'package:tech_gadol_task_app/src/core/use_case/use_case.dart';
import 'package:tech_gadol_task_app/src/core/utils/type_def.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/entities/product_entity.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/repositories/product_repository.dart';

class GetProducts
    implements
        UseCase<(List<ProductEntity>, int, DataSource), GetProductsParams> {
  final ProductRepository _repository;

  const GetProducts(this._repository);

  @override
  Future<FailureOr<(List<ProductEntity>, int, DataSource)>> call(
      GetProductsParams params) {
    return _repository.getProducts(limit: params.limit, skip: params.skip);
  }
}

class GetProductsParams {
  final int limit;
  final int skip;

  const GetProductsParams({this.limit = 20, this.skip = 0});
}
