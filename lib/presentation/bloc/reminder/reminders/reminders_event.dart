part of 'reminders_bloc.dart';

@immutable
abstract class RemindersEvent extends Equatable{}

class RemindersFetchEvent extends RemindersEvent {
  @override
  List<Object?> get props => [];
}

class RemindersDeleteEvent extends RemindersEvent {
  RemindersDeleteEvent(this.id, this.context);
  final String id;
  final BuildContext context;
  @override
  List<Object?> get props => [id];
}
