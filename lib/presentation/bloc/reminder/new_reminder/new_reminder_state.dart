part of 'new_reminder_bloc.dart';

class NewReminderState extends Equatable {
  const NewReminderState({
      this.date = '',
      this.isRepeat = false,
      this.title = '',
      this.description = '',
      this.errorMessage
      });

  final String date;
  final bool isRepeat;
  final String title;
  final String description;
  final String? errorMessage;

  NewReminderState copyWith({
    String? date,
    bool? isRepeat,
    String? title,
    String? description,
    String? errorMessage,
  }) {
    return NewReminderState(
        date: date ?? this.date,
        isRepeat: isRepeat ?? this.isRepeat,
        title: title ?? this.title,
        description: description ?? this.description,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [date, isRepeat, title, description, errorMessage];
}

class NewReminderErrorState extends NewReminderState {
  const NewReminderErrorState(String errorMessage)
      : super(errorMessage: errorMessage);
}
