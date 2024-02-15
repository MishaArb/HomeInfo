import '../../core/request_result/request_result.dart';
import '../../core/usecase/usecase.dart';
import '../entities/service_entity.dart';
import '../repository/home_services_db_repository.dart';

class FetchHomeServicesUseCase
    implements UseCase<RequestResult<List<HomeServiceEntity>>, void> {
  FetchHomeServicesUseCase(this.homeServicesDBRepository);

  final HomeServicesDBRepository homeServicesDBRepository;

  @override
  Future<RequestResult<List<HomeServiceEntity>>> call({void params}) async {
    return await homeServicesDBRepository.fetchServices();
  }
}
