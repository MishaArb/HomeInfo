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
