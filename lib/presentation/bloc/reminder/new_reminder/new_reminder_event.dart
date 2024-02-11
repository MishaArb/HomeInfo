part of 'new_reminder_bloc.dart';

@immutable
abstract class NewReminderEvent {}


class NewReminderPickDateEvent extends NewReminderEvent {
  NewReminderPickDateEvent(this.ctx);

  final BuildContext ctx;
}

class NewReminderRepeatEvent extends NewReminderEvent {
  NewReminderRepeatEvent(this.isRepeat);

  final bool isRepeat;
}

class NewReminderSaveEvent extends NewReminderEvent{
  final String title;
  final String description;
  final BuildContext cxt;
  NewReminderSaveEvent({required this.cxt, required this.title, required this.description});
}