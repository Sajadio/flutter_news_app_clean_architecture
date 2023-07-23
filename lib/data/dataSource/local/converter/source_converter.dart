import 'package:floor/floor.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/source_entity.dart';

class SourceConverter extends TypeConverter<SourceEntity?, String> {
  @override
  SourceEntity? decode(String databaseValue) {
    final List<String> results = databaseValue.split(',');
    return SourceEntity(id: results.first, name: results.last);
  }

  @override
  String encode(SourceEntity? value) {
    final String result = '${value?.id}, ${value?.name}';
    return result;
  }
}
