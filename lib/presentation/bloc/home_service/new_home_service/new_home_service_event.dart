part of 'new_home_service_bloc.dart';

@immutable
abstract class NewHomeServiceEvent extends Equatable {}

class ServiceSaveEvent extends NewHomeServiceEvent {
  ServiceSaveEvent(this.title, this.context);

  final String title;
  final BuildContext context;

  @override
  List<Object?> get props => [title, context];
}

class NewHomeServiceSelectIconEvent extends NewHomeServiceEvent {
  NewHomeServiceSelectIconEvent({
    required this.icon,
  });

  final int icon;

  @override
  List<Object?> get props => [icon];
}

class NewHomeServiceSelectIconColorEvent extends NewHomeServiceEvent {
  NewHomeServiceSelectIconColorEvent({
    required this.iconColor,
  });

  final int iconColor;

  @override
  List<Object?> get props => [iconColor];
}
