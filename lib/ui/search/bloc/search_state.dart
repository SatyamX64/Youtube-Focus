library search_state;

import 'package:youtube_focus/data/models/search/search_barrel.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'search_state.g.dart';

abstract class SearchState implements Built<SearchState, SearchStateBuilder> {
  BuiltList<SearchItem> get items;
  bool get hasReachedEndOfResults;
  bool get isLoading;
  String get error;

  bool get isInitial => !isLoading && items.isEmpty && error == '';
  bool get isSuccessful =>
      !isLoading && items.isNotEmpty && error == '';

  SearchState._();

  factory SearchState([updates(SearchStateBuilder b)]) = _$SearchState;

  factory SearchState.initial() {
    return SearchState((b) => b
      ..isLoading = false
      ..items.replace(BuiltList<SearchItem>())
      ..error = ''
      ..hasReachedEndOfResults = false);
  }

  factory SearchState.loading() {
    return SearchState((b) => b
      ..isLoading = true
      ..items.replace(BuiltList<SearchItem>())
      ..error = ''
      ..hasReachedEndOfResults = false);
  }

  factory SearchState.failure(String error) {
    return SearchState((b) => b
      ..isLoading = false
      ..items.replace(BuiltList<SearchItem>())
      ..error = error
      ..hasReachedEndOfResults = false);
  }

  factory SearchState.success(BuiltList<SearchItem> resultList) {
    return SearchState((b) => b
      ..isLoading = false
      ..items.replace(resultList)
      ..error = ''
      ..hasReachedEndOfResults = false);
  }
}
