import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:youtube_focus/data/models/search/search_barrel.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Thumbnail,
  Thumbnails,
  Id,
  SearchItem,
  SearchResponse,
  SearchSnippet,
])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
