import '../../core/request_result/request_result.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/repository/home_services_db_repository.dart';
import '../data_sources/sqflite_db_service.dart';
import '../model/home_service_model.dart';

class HomeServicesDBRepositoryImpl implements HomeServicesDBRepository {
  HomeServicesDBRepositoryImpl(this.dbServices);

  final SQfliteDBServices dbServices;

  @override
  Future<RequestResult<List<HomeServiceModel>>> fetchServices() async {
    try {
      final allServices = await dbServices.getAllHomeServices();

      return RequestSuccess(allServices);
    } catch (e) {
      return RequestError(e.toString());
    }
  }

  @override
  Future<RequestResult<HomeServiceEntity>> createService(
      HomeServiceEntity service) async {
    try {
      await dbServices
          .createNewHomeService(HomeServiceModel.fromEntity(service));
      return RequestSuccess(service);
    } catch (e) {
      return RequestError(e.toString());
    }
  }

  @override
  Future<RequestResult<String>> deleteService(String id) async {
    try {
      await dbServices.deleteHomeService(id);
      return RequestSuccess(id);
    } catch (e) {
      return RequestError(e.toString());
    }
  }
}
