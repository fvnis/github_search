import 'package:github_search/app/search/domain/states/search_state.dart';

abstract class SearchRepository {
  Future<SearchState> getUsers(String textSearch);
}
