// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter_news_app_clean_architecture/data/dataSource/local_data_source.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/mapper/dto/map_dto_to_entity.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/mapper/entites/map_domain_to_entity.dart';
import 'package:flutter_news_app_clean_architecture/data/dataSource/remote_data_source.dart';
import 'package:flutter_news_app_clean_architecture/domain/mapper/map_cache_entity_to_domain.dart';
import 'package:flutter_news_app_clean_architecture/domain/mapper/map_entity_to_domain.dart';
import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';
import 'package:flutter_news_app_clean_architecture/domain/repository/repository.dart';
import 'package:flutter_news_app_clean_architecture/domain/utils/resource.dart';
import 'package:connectivity/connectivity.dart';

class RepositoryImpl implements Repository {
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;

  RepositoryImpl(
    this._localDataSource,
    this._remoteDataSource,
  );

  @override
  void refreshCacheData(String? category) async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw const SocketException("No internet connection");
      }

      final httpResponse = await _remoteDataSource.getNewsDto(
        "a8028cd39d0445fe97c1ec3cc5bc2561",
        category,
        20,
        1,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        final entities = mapArticleDtoToCacheArticleEntity(
          httpResponse.data.articles,
          category,
        );
        _localDataSource.addCacheData(entities);
      } else {
        throw const SocketException("Failed to fetch data");
      }
    } on SocketException catch (e) {
      print("No internet connection: $e");
    } on Exception catch (e) {
      print("Error occurred: $e");
    }
  }

  @override
  Future<Resource<List<Article>>> getCacheDataByCategory(
      String category) async {
    refreshCacheData(category);
    return await _wrapWithResource(() async {
      final entities = await _localDataSource.getCacheDataByCategory(category);
      final articles = mapCacheArticleEntityToArticleDomain(entities);
      return articles;
    });
  }

  @override
  Future<Resource<List<Article>>> getAllSavedArticles() async {
    return await _wrapWithResource(() async {
      final entities = await _localDataSource.getAllSavedArticles();
      final articles = mapArticleEntityToArticleDomain(entities);
      return articles;
    });
  }

  @override
  void deleteAllArticles() async {
    return _localDataSource.deleteAllArticles();
  }

  @override
  void addArticle(Article article) async {
    final entity = mapArticleDomainToArticleEntity([article]).first;
    await _localDataSource.addArticle(entity);
  }

  @override
  void deleteArticle(Article article) async {
    final entity = mapArticleDomainToArticleEntity([article]).first;
    await _localDataSource.deleteArticle(entity);
  }

  @override
  Future<bool?> didArticleSave(int id) async {
    return _localDataSource.didArticleSave(id);
  }

  @override
  Future<Resource<Article>> getArticleById(int id) async {
    return await _wrapWithResource(() async {
      final entity = await _localDataSource.getArticleById(id);
      if (entity != null) {
        final maEntity = mapArticleEntityToArticleDomain([entity]).first;
        return maEntity;
      } else {
        throw Exception('Article not found');
      }
    });
  }

  Future<Resource<T>> _wrapWithResource<T>(
      Future<T> Function() function) async {
    try {
      final data = await function();
      if (data != null) {
        return Resource.success(data);
      } else {
        return Resource.failure(Exception('Article not found'));
      }
    } on Exception catch (e) {
      return Resource.failure(e);
    }
  }
}
