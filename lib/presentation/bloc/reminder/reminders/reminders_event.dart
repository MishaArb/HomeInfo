part of 'reminders_bloc.dart';

@immutable
abstract class RemindersEvent extends Equatable{}

class RemindersFetchEvent extends RemindersEvent {
  @override
  List<Object?> get props => [];
}

class RemindersDeleteEvent extends RemindersEvent {
  RemindersDeleteEvent({
    required this.id,
    required this.notificationId,
    required this.context,
  });
  final String id;
  final int notificationId;
  final BuildContext context;
  @override
  List<Object?> get props => [id, notificationId, context];
}
