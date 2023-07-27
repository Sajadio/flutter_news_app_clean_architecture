import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';
import 'package:flutter_news_app_clean_architecture/domain/repository/repository.dart';
import 'package:flutter_news_app_clean_architecture/domain/utils/resource.dart';

class GetCacheCaseCase {
  final Repository _repo;

  GetCacheCaseCase(this._repo);

  Future<Resource<List<Article>>> call(String category) {
    return _repo.getCacheDataByCategory(category);
  }
}
