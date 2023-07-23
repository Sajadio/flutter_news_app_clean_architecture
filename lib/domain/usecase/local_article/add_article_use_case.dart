import 'package:flutter_news_app_clean_architecture/domain/model/article.dart';

import 'package:flutter_news_app_clean_architecture/domain/repository/repository.dart';

class AddArticleCaseCase {
  final Repository _repo;

  AddArticleCaseCase(this._repo);

  Future<void> call(Article article) {
    return _repo.addArticle(article);
  }
}
