import '../../core/request_result/request_result.dart';
import '../../core/usecase/usecase.dart';
import '../repository/reading_db_repository.dart';

class DeleteReadingUseCase implements UseCase<RequestResult<String>, String> {
  DeleteReadingUseCase(this.readingDBRepository);

  final ReadingDBRepository readingDBRepository;

  @override
  Future<RequestResult<String>> call({String? params}) async {
    return await readingDBRepository.deleteReading(params!);
  }
}
