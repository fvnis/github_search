import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/app_module.dart';
import 'package:github_search/app/search/domain/repositories/search_repository.dart';
import 'package:github_search/app/search/domain/states/search_state.dart';
import 'package:mocktail/mocktail.dart';

import 'search/data/datasources/github/github_response.dart';

class DioMock extends Mock implements Dio {}

class SearchRepositoryMock extends Mock implements SearchRepository {
  @override
  Future<SearchState> getUsers(String textSearch) async {
    return const SuccessState([]);
  }
}

main() {
  Modular.bindModule(AppModule());
  Modular.replaceInstance<SearchRepository>(SearchRepositoryMock());
  Modular.replaceInstance<Dio>(DioMock());

  final dio = Modular.get<Dio>();

  test("Deve recuperar o repository sem erro", () {
    final repository = Modular.get<SearchRepository>();

    expect(repository, isA<SearchRepository>());
  });

  test("Deve retornar um SuccessState se o datasource retornar uma lista",
      () async {
    when(() => dio.get(any())).thenAnswer((_) async => Response(
        data: jsonDecode(gitHubResponse),
        statusCode: 200,
        requestOptions: RequestOptions()));

    final repository = Modular.get<SearchRepository>();
    final result = await repository.getUsers("eduardo");

    expect(result, isA<SuccessState>());
  });
}
