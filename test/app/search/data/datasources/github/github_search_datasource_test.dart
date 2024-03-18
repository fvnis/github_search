import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search/app/search/data/datasources/github/github_search_datasource.dart';
import 'package:github_search/app/search/domain/errors/search_errors.dart';
import 'package:mocktail/mocktail.dart';

import 'github_response.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();

  final datasource = GithubSearchDatasource(dio);

  test("Deve retornar um Exception se tiver um erro no Dio", () async {
    when(() => dio.get(any())).thenThrow(Exception());
    final future = datasource.searchText("eduardo");
    expect(future, throwsA(isA<Exception>()));
  });

  test("Deve retornar um DatasourceError se o status for diferente de 200",
      () async {
    when(() => dio.get(any())).thenAnswer((_) async => Response(
        data: null, statusCode: 401, requestOptions: RequestOptions()));
    final future = datasource.searchText("eduardo");
    expect(future, throwsA(isA<DatasourceError>()));
  });

  test("Deve retornar uma lista de ResultModel", () async {
    when(() => dio.get(any())).thenAnswer((_) async => Response(
        data: jsonDecode(gitHubResponse),
        statusCode: 200,
        requestOptions: RequestOptions()));
    final future = datasource.searchText("eduardo");
    expect(future, completes);
  });
}
