import 'package:dartz/dartz.dart';
import 'package:tech_gadol_task_app/src/core/errors/failure.dart';

typedef FailureOr<T> = Either<Failure, T>;
