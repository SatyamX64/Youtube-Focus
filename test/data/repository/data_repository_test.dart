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
    group('Data Repository - Search Videos', () {
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
        try{
          await dataRepository.searchVideos(query: 'dragon');
        } catch(e){
          expect(e, SearchResponseException);
        }
      });
    });
  });
}
