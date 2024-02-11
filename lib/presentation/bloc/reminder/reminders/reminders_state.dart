part of 'reminders_bloc.dart';

abstract class RemindersState extends Equatable {}

final class RemindersLoadingState extends RemindersState {
  @override
  List<Object?> get props => [];
}

final class RemindersSuccessState extends RemindersState {
  final List<ReminderEntity> reminders;

  RemindersSuccessState(this.reminders);

  @override
  List<Object?> get props => [reminders];
}

final class RemindersErrorState extends RemindersState {
  RemindersErrorState(this.errorMessage);

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
