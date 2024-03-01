import '../../core/request_result/request_result.dart';
import '../../data/model/reading_model.dart';

abstract interface class ReadingDBRepository {
  Future<RequestResult<List<ReadingModel>>> fetchReadings();

  Future<RequestResult<ReadingModel>> createReading(ReadingModel reading);

  Future<RequestResult<ReadingModel>> updateReading(ReadingModel reading);

  Future<RequestResult<String>> deleteReading(String id);
}
