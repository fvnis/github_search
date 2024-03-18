import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/app/search/data/datasources/github/github_search_datasource.dart';
import 'package:github_search/app/search/data/datasources/search_datasource.dart';
import 'package:github_search/app/search/data/repositories/search_repository_impl.dart';
import 'package:github_search/app/search/domain/blocs/search_bloc.dart';
import 'package:github_search/app/search/domain/repositories/search_repository.dart';
import 'package:github_search/app/search/ui/search_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addInstance<Dio>(Dio());
    i.add<SearchDatasource>(GithubSearchDatasource.new);
    i.add<SearchRepository>(SearchRepositoryImpl.new);
    i.addSingleton<SearchBloc>(SearchBloc.new);
  }

  @override
  void routes(r) {
    r.child(
      "/",
      child: (context) => const SearchPage(),
    );
  }
}
