import 'dart:async';

import 'package:floor/floor.dart';

import 'package:flutter_news_app_clean_architecture/data/dataSource/local/dao/article_dao.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/article_entity.dart';

import 'package:flutter_news_app_clean_architecture/data/dataSource/local/entities/cache_article_entity.dart';

import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [CacheArticleEntity, ArticleEntity])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}
