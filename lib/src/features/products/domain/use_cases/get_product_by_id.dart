import 'package:tech_gadol_task_app/src/core/enums/data_source.dart';
import 'package:tech_gadol_task_app/src/core/use_case/use_case.dart';
import 'package:tech_gadol_task_app/src/core/utils/type_def.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/entities/product_entity.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/repositories/product_repository.dart';

class GetProductById
    implements UseCase<(ProductEntity, DataSource), int> {
  final ProductRepository _repository;

  const GetProductById(this._repository);

  @override
  Future<FailureOr<(ProductEntity, DataSource)>> call(int params) {
    return _repository.getProductById(params);
  }
}
