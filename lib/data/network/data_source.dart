import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtube_focus/data/models/search/search_barrel.dart';
import 'api_key.dart';

const MAX_RESULT_PER_PAGE = 5;

class DataSource {
  final _videoBaseURL = 'https://youtube.googleapis.com/youtube/v3/search' +
      '?part=snippet' +
      '&maxResults=$MAX_RESULT_PER_PAGE' +
      '&type=video';
  final http.Client client;

  DataSource(this.client);

  Future<SearchResponse> searchVideos(
      {required String query, String? pageToken}) async {
    final rawURL = _videoBaseURL +
        '&q=$query' +
        (pageToken != null ? '&pageToken=$pageToken' : '') +
        '&key=$API_KEY';

    final encoded = Uri.encodeFull(rawURL);
    final response = await client.get(Uri.parse(encoded));
    if (response.statusCode == 200) {
      return SearchResponse.fromJson(response.body);
    } else {
      throw SearchResponseException(
          json.decode(response.body)['error']['message']);
    }
  }
}

class SearchResponseException implements Exception {
  final String message;
  SearchResponseException(this.message);
}
