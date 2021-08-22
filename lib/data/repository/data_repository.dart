import 'package:flutter/cupertino.dart';
import 'package:youtube_focus/data/models/search/search_barrel.dart';
import 'package:youtube_focus/data/network/data_source.dart';
import 'package:built_collection/built_collection.dart';

class DataRepository {
  String? _pageToken;
  String? _searchQuery;

  @visibleForTesting
  String? get pageToken => _pageToken;

  DataSource dataSource;

  DataRepository(this.dataSource);

  Future<BuiltList<SearchItem>> searchVideos({required String query}) async {
    final searchResponse = await dataSource.searchVideos(query: query);
    if (searchResponse.items.isEmpty) {
      throw NoItemsFoundException();
    }
    _cacheValues(query: query, pageToken: searchResponse.nextPageToken);
    return searchResponse.items;
  }

  void _cacheValues({required query, String? pageToken}) {
    _pageToken = pageToken;
    _searchQuery = query;
  }
}

class NoItemsFoundException implements Exception {
  final message = 'No Items found for given query';
}
