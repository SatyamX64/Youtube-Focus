// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_event.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SearchVideos extends SearchVideos {
  @override
  final String query;

  factory _$SearchVideos([void Function(SearchVideosBuilder)? updates]) =>
      (new SearchVideosBuilder()..update(updates)).build();

  _$SearchVideos._({required this.query}) : super._() {
    BuiltValueNullFieldError.checkNotNull(query, 'SearchVideos', 'query');
  }

  @override
  SearchVideos rebuild(void Function(SearchVideosBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchVideosBuilder toBuilder() => new SearchVideosBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchVideos && query == other.query;
  }

  @override
  int get hashCode {
    return $jf($jc(0, query.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SearchVideos')..add('query', query))
        .toString();
  }
}

class SearchVideosBuilder
    implements Builder<SearchVideos, SearchVideosBuilder> {
  _$SearchVideos? _$v;

  String? _query;
  String? get query => _$this._query;
  set query(String? query) => _$this._query = query;

  SearchVideosBuilder();

  SearchVideosBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _query = $v.query;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchVideos other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SearchVideos;
  }

  @override
  void update(void Function(SearchVideosBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SearchVideos build() {
    final _$result = _$v ??
        new _$SearchVideos._(
            query: BuiltValueNullFieldError.checkNotNull(
                query, 'SearchVideos', 'query'));
    replace(_$result);
    return _$result;
  }
}

class _$FetchNextPage extends FetchNextPage {
  factory _$FetchNextPage([void Function(FetchNextPageBuilder)? updates]) =>
      (new FetchNextPageBuilder()..update(updates)).build();

  _$FetchNextPage._() : super._();

  @override
  FetchNextPage rebuild(void Function(FetchNextPageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FetchNextPageBuilder toBuilder() => new FetchNextPageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FetchNextPage;
  }

  @override
  int get hashCode {
    return 602627133;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('FetchNextPage').toString();
  }
}

class FetchNextPageBuilder
    implements Builder<FetchNextPage, FetchNextPageBuilder> {
  _$FetchNextPage? _$v;

  FetchNextPageBuilder();

  @override
  void replace(FetchNextPage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$FetchNextPage;
  }

  @override
  void update(void Function(FetchNextPageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$FetchNextPage build() {
    final _$result = _$v ?? new _$FetchNextPage._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
