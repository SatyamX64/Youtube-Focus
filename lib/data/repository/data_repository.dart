import 'package:flutter/cupertino.dart';
import 'package:youtube_focus/data/models/search/search_barrel.dart';
import 'package:youtube_focus/data/network/data_source.dart';
import 'package:built_collection/built_collection.dart';

class DataRepository {
  String? _pageToken;
  String? _lastSearchQuery;

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
    _lastSearchQuery = query;
  }

  Future<BuiltList<SearchItem>> fetchMoreVideos() async {
    if (_pageToken != null && _lastSearchQuery != null) {
      final nextPageSearchResponse = await dataSource.searchVideos(
          query: _lastSearchQuery!, pageToken: _pageToken!);
      _cacheValues(
          query: _lastSearchQuery, pageToken: nextPageSearchResponse.nextPageToken);
      return nextPageSearchResponse.items;
    } else {
      throw InvalidPageTokenException();
    }
  }
}

class NoItemsFoundException implements Exception {
  final message = 'No Items found for given query';
}

class InvalidPageTokenException implements Exception {
  final message = 'Invalid Page Token';
}
