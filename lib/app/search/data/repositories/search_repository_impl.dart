import 'package:github_search/app/search/data/datasources/search_datasource.dart';
import 'package:github_search/app/search/domain/errors/search_errors.dart';
import 'package:github_search/app/search/domain/repositories/search_repository.dart';
import 'package:github_search/app/search/domain/states/search_state.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<SearchState> getUsers(String textSearch) async {
    try {
      final list = await datasource.searchText(textSearch);
      return SuccessState(list);
    } catch (error) {
      return ErrorState(ErrorSearch());
    }
  }
}
