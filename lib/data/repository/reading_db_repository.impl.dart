import 'package:home_info/core/request_result/request_result.dart';

import 'package:home_info/data/model/reading_model.dart';

import '../../domain/repository/reading_db_repository.dart';
import '../data_sources/sqflite_db.dart';

class ReadingDBRepositoryImpl implements ReadingDBRepository {
  ReadingDBRepositoryImpl(this.db);

  final SQfliteDB db;

  @override
  Future<RequestResult<List<ReadingModel>>> fetchReadings() async {
    try {
      final allReadings = await db.getAllReadings();
      return RequestSuccess(allReadings);
    } catch (e) {
      return RequestError(e.toString());
    }
  }

  @override
  Future<RequestResult<ReadingModel>> createReading(
      ReadingModel reading) async {
    try {
      await db.createNewReading(reading);
      return RequestSuccess(reading);
    } catch (e) {
      return RequestError(e.toString());
    }
  }

  @override
  Future<RequestResult<ReadingModel>> updateReading(
      ReadingModel reading) async {
    try {
      await db.updateReading(reading);
      return RequestSuccess(reading);
    } catch (e) {
      return RequestError(e.toString());
    }
  }

  @override
  Future<RequestResult<String>> deleteReading(String id) async {
    try {
      await db.deleteReading(id);
      return RequestSuccess(id);
    } catch (e) {
      return RequestError(e.toString());
    }
  }
}
