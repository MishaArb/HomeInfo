import '../../core/request_result/request_result.dart';
import '../../core/usecase/usecase.dart';
import '../../data/model/reading_model.dart';
import '../repository/reading_db_repository.dart';

class FetchReadingsUseCase
    implements UseCase<RequestResult<List<ReadingModel>>, void> {
  FetchReadingsUseCase(this.readingDBRepository);

  final ReadingDBRepository readingDBRepository;

  @override
  Future<RequestResult<List<ReadingModel>>> call({void params}) async {
    return await readingDBRepository.fetchReadings();
  }
}
