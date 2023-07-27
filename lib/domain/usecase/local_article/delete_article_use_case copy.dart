import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

import 'package:flutter_news_app_clean_architecture/domain/repository/repository.dart';

class DeleteArticleCaseCase {
  final Repository _repo;

  DeleteArticleCaseCase(this._repo);

  void call(Article article) {
    return _repo.deleteArticle(article);
  }
}
