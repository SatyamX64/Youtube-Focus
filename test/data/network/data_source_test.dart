import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_focus/data/models/search/search_barrel.dart';
import 'package:youtube_focus/data/network/api_key.dart';
import 'package:youtube_focus/data/network/data_source.dart';

import 'data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late DataSource dataSource;

  setUp(() {
    mockClient = MockClient();
    dataSource = DataSource(mockClient);
  });

  String fixture(String data) =>
      File('test/data/fixtures/$data.json').readAsStringSync();
  group('Data Source Test', () {
    test('Search Videos', () async {
      when(mockClient.get(any)).thenAnswer(
          (_) async => http.Response(fixture('search_response'), 200));
      var searchResponse = await dataSource.searchVideos(query: 'abcd');
      expect(
          searchResponse, SearchResponse.fromJson(fixture('search_response')));
    });
    test('Search Videos - Error (Throw SearchResponseException)', () async {
      when(mockClient.get(any)).thenAnswer(
          (_) async => http.Response(fixture('search_response_error'), 400));
      expect(dataSource.searchVideos(query: 'abcd'),
          throwsA(TypeMatcher<SearchResponseException>()));
    });

    test('Search - Checks if Request made on correct URL', () async {
      when(mockClient.get(any)).thenAnswer(
          (_) async => http.Response(fixture('search_response'), 200));
      await dataSource.searchVideos(query: 'abcd');
      await dataSource.searchVideos(query: 'dragon', pageToken: '2345');
      await dataSource.searchVideos(query: 'cat videos');
      final capturedURIs = verify(mockClient.get(captureAny)).captured;
      expect(capturedURIs.length, 3);
      expect(
          capturedURIs[0].toString(),
          allOf(
            startsWith('https://youtube.googleapis.com/youtube/v3/search'),
            contains('part=snippet'),
            contains('maxResults=5'),
            contains('q=abcd'),
            contains('type=video'),
            contains('key=$API_KEY'),
            isNot(contains('pageToken')),
          ),
        );
        expect(
          capturedURIs[1].toString(),
          allOf(
            startsWith('https://youtube.googleapis.com/youtube/v3/search'),
            contains('q=dragon'),
            contains('pageToken=2345'),
          ),
        );
        expect(
          capturedURIs[2].toString(),
           allOf(
            startsWith('https://youtube.googleapis.com/youtube/v3/search'),
            contains('q=cat%20videos'),
          ),
        );
    });
  });
}
