import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';
import 'package:flutter_news_app_clean_architecture/domain/repository/repository.dart';
import 'package:flutter_news_app_clean_architecture/domain/utils/resource.dart';

class GetArticleByIdUseCase {
  final Repository _repo;

  GetArticleByIdUseCase(this._repo);

  Future<Resource<Article>> call(int id)  {
    return  _repo.getArticleById(id);
  }
}
