// GENERATED CODE - DO NOT MODIFY BY HAND

part of search_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SearchState extends SearchState {
  @override
  final BuiltList<SearchItem> items;
  @override
  final bool hasReachedEndOfResults;
  @override
  final bool isLoading;
  @override
  final String error;

  factory _$SearchState([void Function(SearchStateBuilder)? updates]) =>
      (new SearchStateBuilder()..update(updates)).build();

  _$SearchState._(
      {required this.items,
      required this.hasReachedEndOfResults,
      required this.isLoading,
      required this.error})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(items, 'SearchState', 'items');
    BuiltValueNullFieldError.checkNotNull(
        hasReachedEndOfResults, 'SearchState', 'hasReachedEndOfResults');
    BuiltValueNullFieldError.checkNotNull(
        isLoading, 'SearchState', 'isLoading');
    BuiltValueNullFieldError.checkNotNull(error, 'SearchState', 'error');
  }

  @override
  SearchState rebuild(void Function(SearchStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchStateBuilder toBuilder() => new SearchStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchState &&
        items == other.items &&
        hasReachedEndOfResults == other.hasReachedEndOfResults &&
        isLoading == other.isLoading &&
        error == other.error;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, items.hashCode), hasReachedEndOfResults.hashCode),
            isLoading.hashCode),
        error.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SearchState')
          ..add('items', items)
          ..add('hasReachedEndOfResults', hasReachedEndOfResults)
          ..add('isLoading', isLoading)
          ..add('error', error))
        .toString();
  }
}

class SearchStateBuilder implements Builder<SearchState, SearchStateBuilder> {
  _$SearchState? _$v;

  ListBuilder<SearchItem>? _items;
  ListBuilder<SearchItem> get items =>
      _$this._items ??= new ListBuilder<SearchItem>();
  set items(ListBuilder<SearchItem>? items) => _$this._items = items;

  bool? _hasReachedEndOfResults;
  bool? get hasReachedEndOfResults => _$this._hasReachedEndOfResults;
  set hasReachedEndOfResults(bool? hasReachedEndOfResults) =>
      _$this._hasReachedEndOfResults = hasReachedEndOfResults;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  SearchStateBuilder();

  SearchStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _items = $v.items.toBuilder();
      _hasReachedEndOfResults = $v.hasReachedEndOfResults;
      _isLoading = $v.isLoading;
      _error = $v.error;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SearchState;
  }

  @override
  void update(void Function(SearchStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SearchState build() {
    _$SearchState _$result;
    try {
      _$result = _$v ??
          new _$SearchState._(
              items: items.build(),
              hasReachedEndOfResults: BuiltValueNullFieldError.checkNotNull(
                  hasReachedEndOfResults,
                  'SearchState',
                  'hasReachedEndOfResults'),
              isLoading: BuiltValueNullFieldError.checkNotNull(
                  isLoading, 'SearchState', 'isLoading'),
              error: BuiltValueNullFieldError.checkNotNull(
                  error, 'SearchState', 'error'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SearchState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
