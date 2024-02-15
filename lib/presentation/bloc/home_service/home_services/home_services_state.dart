part of 'home_services_bloc.dart';

@immutable
abstract class HomeServicesState extends Equatable  {}

class ServicesLoadingState extends HomeServicesState {

  @override
  List<Object?> get props => [];
}
class HomeServicesSuccessState extends HomeServicesState {
  HomeServicesSuccessState(this.services);
  final List<HomeServiceEntity> services;
  @override
  List<Object?> get props => [services];
}

class HomeServicesErrorState extends HomeServicesState {
  HomeServicesErrorState(this.errorMessage);

  final String errorMessage;
  @override
  List<Object?> get props => [errorMessage];
}
