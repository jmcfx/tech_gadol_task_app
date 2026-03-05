import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  final String message;

  final String? details;

  const Failure({required this.message, this.details});

  @override
  List<Object?> get props => [message, details];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = "Server error", super.details});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = "Cache error", super.details});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message = "Unknown error", super.details});
}

class NoInternetFailure extends Failure {
  const NoInternetFailure({
    super.message = "No internet connection",
    super.details,
  });
}
