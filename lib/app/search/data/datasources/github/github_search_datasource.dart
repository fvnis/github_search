import 'package:dio/dio.dart';
import 'package:github_search/app/search/data/datasources/search_datasource.dart';
import 'package:github_search/app/search/data/models/result_model.dart';
import 'package:github_search/app/search/domain/errors/search_errors.dart';

class GithubSearchDatasource implements SearchDatasource {
  final Dio dio;

  GithubSearchDatasource(this.dio);

  @override
  Future<List<ResultModel>> searchText(String textSearch) async {
    final response = await dio.get(
      'https://api.github.com/search/users?q=${textSearch.trim().replaceAll(' ', '+')}',
    );

    if (response.statusCode == 200) {
      final json = response.data['items'] as List;
      final list = json
          .map((item) => ResultModel(
                image: item['avatar_url'],
                name: item['login'],
                nickname: item['login'],
                url: item['html_url'],
              ))
          .toList();
      return list;
    } else {
      throw DatasourceError();
    }
  }
}
