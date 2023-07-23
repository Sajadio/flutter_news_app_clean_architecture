import '../../repository/repository.dart';

class DeleteAllArticlesUseCase {
  final Repository _repo;

  DeleteAllArticlesUseCase(this._repo);

  Future<void> call() {
    return _repo.deleteAllArticles();
  }
}
