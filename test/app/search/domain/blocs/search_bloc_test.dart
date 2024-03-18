import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/search/data/models/result_model.dart';
import 'package:github_search/app/search/domain/blocs/search_bloc.dart';
import 'package:github_search/app/search/domain/errors/search_errors.dart';
import 'package:github_search/app/search/domain/repositories/search_repository.dart';
import 'package:github_search/app/search/domain/states/search_state.dart';
import 'package:mocktail/mocktail.dart';

class SearchRepositoryMock extends Mock implements SearchRepository {}

void main() {
  final repository = SearchRepositoryMock();

  test("Deve retornar ErrorState", () {
    final bloc = SearchBloc(repository);
    when(() => repository.getUsers(any()))
        .thenAnswer((_) async => ErrorState(ErrorSearch()));
    expect(
      bloc.stream,
      emitsInOrder(
        [isA<LoadingState>(), isA<ErrorState>()],
      ),
    );
    bloc.add("eduardo");
  });

  test("Deve retornar os estados na ordem correta", () {
    final bloc = SearchBloc(repository);

    when(() => repository.getUsers("eduardo"))
        .thenAnswer((_) async => const SuccessState(<ResultModel>[]));
    expect(
      bloc.stream,
      emitsInOrder(
        [isA<LoadingState>(), isA<SuccessState>()],
      ),
    );
    bloc.add("eduardo");
  });
}
