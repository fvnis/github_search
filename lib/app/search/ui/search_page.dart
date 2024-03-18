import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/app/search/domain/blocs/search_bloc.dart';
import 'package:github_search/app/search/domain/entities/result.dart';
import 'package:github_search/app/search/domain/errors/search_errors.dart';
import 'package:github_search/app/search/domain/states/search_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  Widget _buildList(List<Result> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.image),
          ),
          title: Text(item.nickname),
        );
      },
    );
  }

  Widget _buildError(Failure error) {
    if (error is EmptyList) return const Center(child: Text("Empty List"));
    if (error is ErrorSearch) return const Center(child: Text("Error"));

    return const Center(child: Text("Fatal Error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Github Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
              onChanged: bloc.add,
            ),
          ),
          Expanded(
            child: StreamBuilder<SearchState>(
              stream: bloc.stream,
              builder: (context, snapshot) {
                final state = bloc.state;

                if (state is ErrorState) {
                  return _buildError(state.error);
                }

                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is SuccessState) {
                  return _buildList(state.list);
                }

                return const Center(child: Text("Type something to search"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
