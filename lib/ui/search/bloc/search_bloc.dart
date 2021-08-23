import 'package:bloc/bloc.dart';
import 'package:youtube_focus/data/network/data_source.dart';
import 'package:youtube_focus/data/repository/data_repository.dart';

import 'bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final DataRepository dataRepository;

  SearchBloc(this.dataRepository) : super(SearchState.initial());

  void searchVideos({required String query}) {
    add(SearchVideos((b) => b..query = query));
  }

  void fetchNextPage() {
    add(FetchNextPage());
  }

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchVideos) {
      yield* mapSearchVideos(event);
    } else if (event is FetchNextPage) {
      yield* mapFetchNextPage();
    }
  }

  Stream<SearchState> mapSearchVideos(SearchVideos event) async* {
    if (event.query.isEmpty) {
      yield SearchState.initial();
    } else {
      yield SearchState.loading();
      try {
        final searchItems =
            await dataRepository.searchVideos(query: event.query);
        yield SearchState.success(searchItems);
      } on NoItemsFoundException catch (e) {
        yield SearchState.failure(e.message);
      } on SearchResponseException catch (e) {
        yield SearchState.failure(e.message);
      }
    }
  }

  Stream<SearchState> mapFetchNextPage() async* {
    try {
      final newSearchItems = await dataRepository.fetchNextPage();
      yield SearchState.success(state.items + newSearchItems);
    } on InvalidPageTokenException catch (e) {
      yield state.rebuild((b) => b..hasReachedEndOfResults = true);
    } on SearchResponseException catch (e) {
      yield SearchState.failure(e.message);
    }
  }
}
