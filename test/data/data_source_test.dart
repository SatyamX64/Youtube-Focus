import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_focus/data/models/search/search_barrel.dart';
import 'package:youtube_focus/data/network/api_key.dart';

part 'data_source_test.mocks.dart';

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
    test('Search Videos', () {
      when(mockClient.get(any)).thenAnswer(
          (_) async => http.Response(fixture('search_response'), 200));
      var searchResponse = dataSource.searchVideos(query: 'abcd');
      expect(
          searchResponse, SearchResponse.fromJson(fixture('search_response')));
    });
    test('Search Videos - Error (Throw NoSearchResultException)', () {
      when(mockClient.get(any)).thenAnswer(
          (_) async => http.Response(fixture('search_response_error'), 400));
      expect(
          dataSource.searchVideos(query: 'abcd'), throwsA(TypeMatcher<NoSearchResultException>));
    });

    test('Search - Checks if Request made on correct URL', (){
      when(mockClient.get(any)).thenAnswer((_) => http.Response(fixture('search_response'), 200));
      dataSource.searchVideos(query : 'abcd');
      dataSource.searchVideos(query : 'dragon', pageToken : '2345');
      dataSource.searchVideos(query : 'cat videos');

      verifyInOrder([
        mockClient.get(argThat(
            allOf(
              startsWith('https://www.googleapis.com/youtube/v3/search'),
              contains('part=snippet'),
              contains('maxResults=5'),
              contains('q=abcd'),
              contains('type=video'),
              contains('key=$API_KEY'),
              isNot(contains('pageToken')),
            ),
          )),
          mockClient.get(argThat(
            allOf(
              startsWith('https://www.googleapis.com/youtube/v3/search'),
              contains('q=dragon'),
              contains('pageToken=2345'),
            ),
          )),
          mockClient.get(argThat(
            allOf(
              startsWith('https://www.googleapis.com/youtube/v3/search'),
              contains('q=cute%20videos'),
            ),
          )),
      ]);

    });
  });
}
