import '../../core/request_result/request_result.dart';
import '../../core/usecase/usecase.dart';
import '../entities/service_entity.dart';
import '../repository/home_services_db_repository.dart';

class SaveHomeServiceUseCase
    implements UseCase<RequestResult<HomeServiceEntity>, HomeServiceEntity> {
  SaveHomeServiceUseCase(this.homeServicesDBRepository);

  final HomeServicesDBRepository homeServicesDBRepository;

  @override
  Future<RequestResult<HomeServiceEntity>> call(
      {HomeServiceEntity? params}) async {
    return await homeServicesDBRepository.createService(params!);
  }
}
