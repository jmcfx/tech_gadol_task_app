import 'package:tech_gadol_task_app/src/core/errors/exceptions.dart';
import 'package:tech_gadol_task_app/src/core/errors/failure.dart';

Failure mapExceptionToFailure(Object param) {
  return switch (param) {
    CacheException _ => CacheFailure(details: param.toString()),
    UnknownException _ => UnknownFailure(details: param.toString()),
    NetworkException _ => NoInternetFailure(details: param.toString()),
    _ => ServerFailure(details: param.toString()),
  };
}
