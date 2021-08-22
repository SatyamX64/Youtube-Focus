import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:youtube_focus/data/models/search/search_barrel.dart';
import 'package:youtube_focus/data/network/data_source.dart';
import 'package:youtube_focus/data/repository/data_repository.dart';

import 'data_repository_test.mocks.dart';

@GenerateMocks([DataSource])
void main() {
  late MockDataSource mockDataSource;
  late DataRepository dataRepository;

  String fixture(String data) =>
      File('test/data/fixtures/$data.json').readAsStringSync();

  final searchResponse = SearchResponse.fromJson(fixture('search_response'));
  final searchResponseNoNextPage =
      SearchResponse.fromJson(fixture('search_response_no_next_page'));
  final searchResponseEmpty =
      SearchResponse.fromJson(fixture('search_response_empty'));

  setUp(() {
    mockDataSource = MockDataSource();
    dataRepository = DataRepository(mockDataSource);
  });

  group('Data Repository Test', () {
    group('Search Videos', () {
      test('Search Video, and set pageToken if available', () async {
        when(mockDataSource.searchVideos(
                query: anyNamed('query'),
                pageToken: argThat(isNull, named: 'pageToken')))
            .thenAnswer((_) async => searchResponse);
        final searchItems = await dataRepository.searchVideos(query: 'dragon');
        expect(searchResponse.items, searchItems);
        expect(dataRepository.pageToken, isNotNull);
        verify(mockDataSource.searchVideos(query: 'dragon'));
      });
      test('Sets pageToken as null, if no next page is available', () async {
        when(mockDataSource.searchVideos(
                query: anyNamed('query'),
                pageToken: argThat(isNull, named: 'pageToken')))
            .thenAnswer((_) async => searchResponseNoNextPage);
        await dataRepository.searchVideos(query: 'dragon');
        expect(dataRepository.pageToken, isNull);
      });
      test('Throws NoItemsFoundException on unknown query string', () async {
        when(mockDataSource.searchVideos(
                query: anyNamed('query'),
                pageToken: argThat(isNull, named: 'pageToken')))
            .thenAnswer((_) async => searchResponseEmpty);
        expect(searchResponseEmpty.items.length, 0);
        expect(() => dataRepository.searchVideos(query: 'dragon'),
            throwsA(isA<NoItemsFoundException>()));
      });
      test('throws SearchResponseException if search failed in data source',
          () async {
        when(mockDataSource.searchVideos(
                query: anyNamed('query'),
                pageToken: argThat(isNull, named: 'pageToken')))
            .thenThrow(SearchResponseException);
        try {
          await dataRepository.searchVideos(query: 'dragon');
        } catch (e) {
          expect(e, SearchResponseException);
        }
      });
    });
    group('Fetch Next Videos', () {
      test(
          'return List<SearchItems> and update token when called AFTER search videos ',
          () async {
        when(mockDataSource.searchVideos(
                query: anyNamed('query'), pageToken: anyNamed('pageToken')))
            .thenAnswer((_) async => searchResponse);
        await dataRepository.searchVideos(
            query: 'dragon'); // this will set the nextPageToken
        final searchItems = await dataRepository.fetchMoreVideos();
        expect(searchItems, searchResponse.items);
        verifyInOrder([
          verify(mockDataSource.searchVideos(
              query: argThat(equals('dragon'), named: 'query'),
              pageToken: argThat(isNull))),
          verify(mockDataSource.searchVideos(
              query: argThat(equals('dragon'), named: 'query'),
              pageToken: argThat(equals(searchResponse.nextPageToken),
                  named: 'pageToken')))
        ]);
      });
      test(
          'throw Exception if fetchMoreVideos called AFTER last Page already reached',
          () async {
        when(mockDataSource.searchVideos(
                query: anyNamed('query'), pageToken: anyNamed('pageToken')))
            .thenAnswer((_) async => searchResponseNoNextPage);
        await dataRepository.searchVideos(query: 'dragon');
        expect(dataRepository.fetchMoreVideos(),
            throwsA(InvalidPageTokenException));
      });

      test(
          'throw Exception if fetchMoreVideos called BEFORE search videos',
          () async {
        when(mockDataSource.searchVideos(
                query: anyNamed('query'), pageToken: anyNamed('pageToken')))
            .thenAnswer((_) async => searchResponse);
        expect(dataRepository.fetchMoreVideos(),
            throwsA(InvalidPageTokenException));
        verifyNever(mockDataSource.searchVideos(query: anyNamed('query')));
      });
    });
  });
}
