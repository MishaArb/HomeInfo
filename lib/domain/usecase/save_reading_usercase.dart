import 'package:home_info/data/model/reading_model.dart';

import '../../core/request_result/request_result.dart';
import '../../core/usecase/usecase.dart';
import '../repository/reading_db_repository.dart';

class CreateReadingUseCase
    implements UseCase<RequestResult<ReadingModel>, ReadingModel> {
  CreateReadingUseCase(this.readingDBRepository);

  final ReadingDBRepository readingDBRepository;

  @override
  Future<RequestResult<ReadingModel>> call({ReadingModel? params}) async {
    return await readingDBRepository.createReading(params!);
  }
}
