import '../../repository/repository.dart';

class DeleteAllArticlesUseCase {
  final Repository _repo;

  DeleteAllArticlesUseCase(this._repo);

  void call() {
    return _repo.deleteAllArticles();
  }
}
