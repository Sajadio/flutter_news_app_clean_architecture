
import '../../repository/repository.dart';

class DeleteHistoryNewsLetterUseCase {
  final Repository _repo;

  DeleteHistoryNewsLetterUseCase(this._repo);

  Future<void> call() {
    return _repo.deleteHistoryNewsLetter();
  }
}
