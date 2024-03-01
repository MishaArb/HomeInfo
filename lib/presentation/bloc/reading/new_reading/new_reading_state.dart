part of 'new_reading_bloc.dart';

class NewReadingCreateState {
  NewReadingCreateState({
    this.readingActionType = ReadingActionType.newReading,
    this.readingId = '',
    String? date,
    this.readingItems = const [],
    this.indexService = 0,
  }) : date = date ?? DateTime.now().toString();

  final ReadingActionType readingActionType;
  final String readingId;
  final String date;
  final int indexService;
  final List<ReadingItem> readingItems;

  NewReadingCreateState copyWith({
    ReadingActionType? readingActionType,
    String? readingId,
    String? date,
    int? indexService,
    String? measureTypeValue,
    List<ReadingItem>? readingItems,
  }) {
    return NewReadingCreateState(
      readingActionType: readingActionType ?? this.readingActionType,
      readingId: readingId ?? this.readingId,
      date: date ?? this.date,
      indexService: indexService ?? this.indexService,
      readingItems: readingItems ?? this.readingItems,
    );
  }
}

class NewReadingSuccessState extends NewReadingCreateState {}

class NewReadingErrorState extends NewReadingCreateState {
  NewReadingErrorState(this.error);

  final String error;
}
