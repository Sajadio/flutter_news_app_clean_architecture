import 'package:flutter_news_app_clean_architecture/domain/repository/repository.dart';

class DidArticleSaveUseCase {
  final Repository _repo;
  DidArticleSaveUseCase(this._repo);

  Future<bool?> call(String url)  {
    return  _repo.didArticleSave(url);
  }
}
