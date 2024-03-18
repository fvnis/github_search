import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/search/data/datasources/search_datasource.dart';
import 'package:github_search/app/search/data/models/result_model.dart';
import 'package:github_search/app/search/data/repositories/search_repository_impl.dart';
import 'package:github_search/app/search/domain/states/search_state.dart';
import 'package:mocktail/mocktail.dart';

class SearchDataSourceMock extends Mock implements SearchDatasource {}

void main() {
  final datasource = SearchDataSourceMock();
  final repository = SearchRepositoryImpl(datasource);

  test("Deve retornar um ErrorState se o datasource falhar", () async {
    when(() => datasource.searchText(any())).thenThrow(Exception());
    final result = await repository.getUsers("eduardo");
    expect(result, isA<ErrorState>());
  });

  test("Deve retornar um SuccessState se o datasource retornar uma lista",
      () async {
    when(() => datasource.searchText("eduardo"))
        .thenAnswer((_) async => <ResultModel>[]);

    final result = await repository.getUsers("eduardo");
    expect(result, isA<SuccessState>());
  });
}
