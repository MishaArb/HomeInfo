part of 'readings_bloc.dart';

@immutable
abstract class ReadingsState extends Equatable{}


class ReadingsLoadingState extends ReadingsState {

  @override
  List<Object?> get props => [];
}
class ReadingsSuccessState extends ReadingsState {
  ReadingsSuccessState(this.readings);
  final List<ReadingModel> readings;
  @override
  List<Object?> get props => [readings];
}

class ReadingsErrorState extends ReadingsState {
  ReadingsErrorState(this.errorMessage);

  final String errorMessage;
  @override
  List<Object?> get props => [errorMessage];
}

