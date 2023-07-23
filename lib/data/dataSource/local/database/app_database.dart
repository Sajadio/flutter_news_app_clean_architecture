import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local/converter/source_converter.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local/dao/history_newsletters_dao.dart';

import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/article_entity.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@TypeConverters([SourceConverter])
@Database(version: 1, entities: [ArticleEntity])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}
