import 'package:tech_gadol_task_app/src/core/enums/data_source.dart';
import 'package:tech_gadol_task_app/src/core/use_case/use_case.dart';
import 'package:tech_gadol_task_app/src/core/utils/type_def.dart';
import 'package:tech_gadol_task_app/src/features/products/data/models/category_model.dart';
import 'package:tech_gadol_task_app/src/features/products/domain/repositories/product_repository.dart';

class GetCategories
    implements UseCase<(List<CategoryModel>, DataSource), NoParams> {
  final ProductRepository _repository;

  const GetCategories(this._repository);

  @override
  Future<FailureOr<(List<CategoryModel>, DataSource)>> call(NoParams params) {
    return _repository.getCategories();
  }
}
