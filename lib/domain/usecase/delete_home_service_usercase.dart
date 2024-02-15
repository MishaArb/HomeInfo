import '../../core/request_result/request_result.dart';
import '../../core/usecase/usecase.dart';
import '../repository/home_services_db_repository.dart';

class DeleteHomeServiceUseCase
    implements UseCase<RequestResult<String>, String> {
  DeleteHomeServiceUseCase(this.homeServicesDBRepository);

  final HomeServicesDBRepository homeServicesDBRepository;

  @override
  Future<RequestResult<String>> call({String? params}) async {
    return await homeServicesDBRepository.deleteService(params!);
  }
}
