library search_response;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:youtube_focus/data/models/search/search_barrel.dart';
import 'package:youtube_focus/data/models/serializers/serializers.dart';

part 'search_response.g.dart';

abstract class SearchResponse
    implements Built<SearchResponse, SearchResponseBuilder> {
  String? get nextPageToken;
  BuiltList<SearchItem> get items;

  SearchResponse._();

  factory SearchResponse([updates(SearchResponseBuilder b)]) = _$SearchResponse;

  String toJson() {
    return json
        .encode(serializers.serializeWith(SearchResponse.serializer, this));
  }

  static SearchResponse fromJson(String jsonString) {
    return serializers.deserializeWith(
        SearchResponse.serializer, json.decode(jsonString))!;
  }

  static Serializer<SearchResponse> get serializer =>
      _$searchResponseSerializer;
}
