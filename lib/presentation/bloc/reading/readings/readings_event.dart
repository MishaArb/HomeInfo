part of 'readings_bloc.dart';

@immutable
abstract class ReadingsEvent extends Equatable {}

class ReadingsFetchEvent extends ReadingsEvent {
  @override
  List<Object?> get props => [];
}

class ReadingsDeleteEvent extends ReadingsEvent {
  ReadingsDeleteEvent({
    required this.id,
    required this.context,
  });

  final String id;
  final BuildContext context;

  @override
  List<Object?> get props => [id, context];
}

class ReadingsShareAllDataEvent extends ReadingsEvent {
  ReadingsShareAllDataEvent(
      {required this.context,
      required this.reading,
      required this.currency,


      });

  final BuildContext context;
  final ReadingModel reading;
  final String currency;

  @override
  List<Object?> get props => [context, reading, currency];
}
