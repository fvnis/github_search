import 'package:bloc/bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/app/search/domain/repositories/search_repository.dart';
import 'package:github_search/app/search/domain/states/search_state.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<String, SearchState> implements Disposable {
  final SearchRepository repository;

  SearchBloc(this.repository) : super(const StartState()) {
    on<String>((textSearch, emit) async {
      if (textSearch.isEmpty) {
        emit(const StartState());
        return;
      }
      emit(const LoadingState());
      final newState = await repository.getUsers(textSearch);
      emit(newState);
    }, transformer: transform());
  }

  EventTransformer<String> transform<LoginEvent>() {
    return (events, mapper) =>
        events.debounceTime(const Duration(milliseconds: 500)).flatMap(mapper);
  }

  @override
  void dispose() {
    close();
  }
}
