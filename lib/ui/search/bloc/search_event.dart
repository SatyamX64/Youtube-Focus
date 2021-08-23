import 'package:built_value/built_value.dart';

part 'search_event.g.dart';

abstract class SearchEvent {}

abstract class SearchVideos extends SearchEvent
    implements Built<SearchVideos, SearchVideosBuilder> {
  String get query;

  SearchVideos._();

  factory SearchVideos([updates(SearchVideosBuilder b)]) =
      _$SearchVideos;
}

abstract class FetchNextPage extends SearchEvent
    implements Built<FetchNextPage, FetchNextPageBuilder> {
  FetchNextPage._();

  factory FetchNextPage([updates(FetchNextPageBuilder b)]) =
      _$FetchNextPage;
}
