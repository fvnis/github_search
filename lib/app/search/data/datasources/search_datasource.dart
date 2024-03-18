import 'package:github_search/app/search/data/models/result_model.dart';

abstract class SearchDatasource {
  Future<List<ResultModel>> searchText(String textSearch);
}
