part of 'home_services_bloc.dart';

@immutable
abstract class HomeServicesEvent extends Equatable {}

class HomeServicesFetchEvent extends HomeServicesEvent {
  @override
  List<Object?> get props => [];
}

class HomeServicesDeleteEvent extends HomeServicesEvent {
  HomeServicesDeleteEvent({
    required this.id,
    required this.context,
  });
  final String id;
  final BuildContext context;
  @override
  List<Object?> get props => [id, context];
}
