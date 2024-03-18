import 'package:github_search/app/search/domain/entities/result.dart';
import 'package:github_search/app/search/domain/errors/search_errors.dart';

abstract class SearchState {}

class StartState implements SearchState {
  const StartState();
}

class LoadingState implements SearchState {
  const LoadingState();
}

class ErrorState implements SearchState {
  final Failure error;
  const ErrorState(this.error);
}

class SuccessState implements SearchState {
  final List<Result> list;

  const SuccessState(this.list);
}
