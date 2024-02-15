import 'package:home_info/data/model/home_service_model.dart';
import 'package:home_info/domain/entities/service_entity.dart';

import '../../core/request_result/request_result.dart';

abstract interface class HomeServicesDBRepository {
  Future<RequestResult<List<HomeServiceModel>>> fetchServices();
  Future<RequestResult<HomeServiceEntity>> createService(HomeServiceEntity service);
  Future<RequestResult<String>> deleteService(String id);
}