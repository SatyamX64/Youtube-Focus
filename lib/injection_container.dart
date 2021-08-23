import 'package:http/http.dart' as http;
import 'package:kiwi/kiwi.dart';

import 'data/network/data_source.dart';
import 'data/repository/data_repository.dart';
import 'ui/search/bloc/bloc.dart';

void initKiwi() {
  KiwiContainer()
    ..registerInstance(http.Client())
    ..registerFactory((container) => DataSource(container.resolve()))
    ..registerFactory((container) => DataRepository(container.resolve()))
    ..registerFactory((container) => SearchBloc(container.resolve()));
}
